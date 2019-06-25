% manifold_GA
% 
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  path_to_trained_model = './trained_model/';
  
  if ~exist('system_of_interest','var'),    system_of_interest = '180403d_8145'; end
  if ~exist('peak_height_threshold','var'), peak_height_threshold = 30;          end
  
  eta_list = [32,16,8,4,2,1.5,1.43,1.25,1.11];
  alpha = 1.0;
  
  trained_model = [path_to_trained_model system_of_interest];
  
  max_T = [41.1878 8.01037 37.1111]; % normalization factors from InterGrowth-21 data.
  
  if ~exist('T','var')
    prompt = {'Abdominal Circumference (cm)','Femur Length (cm)','Head Circumference (cm)'};
    dlgtitle = 'Manifold_GA';
    dims = [1 30; 1 30; 1 30];
    definput = {'15.88' '3.76' '19.79'};
    T = inputdlg(prompt,dlgtitle,dims,definput);
    T = [str2num(T{1}) str2num(T{2}) str2num(T{3})];
  end
  T = bsxfun(@rdivide,T,max_T);
  
  test_data = T;
  clear T
  n_test = size(test_data,1);
  
  squeezed = [trained_model '/squeezed_reconstructed_data.mat'];
  load(squeezed,'T')
  training_data = T(2:end,:);
  clear T
  n_train = size(training_data,1);
  
  training_info_stack = dir([trained_model '/training_info*']);
  name_template = training_info_stack(1).name;
  nS    = str2num(parse_string(name_template,'_nS','_'));
  nN    = str2num(parse_string(name_template,'_nN','_'));
  nEigs = str2num(parse_string(name_template,'_nEigs','.mat'));
  
  num_sigma = numel(training_info_stack);
  num_eta = numel(eta_list);
  fit_table = zeros(num_sigma,num_eta,n_test);
  
  for j_sigma=1:num_sigma
    training_info = training_info_stack(j_sigma).name;
    sigma_Ny = str2num(parse_string(training_info,'_sigma','_'));
    
% Squared Distance Calculation
    sqDist_Ny = dmat(test_data',training_data');
    [~,col_ind]= sort(sqDist_Ny,2,'ascend');
    sqDist_Ny(bsxfun(@plus,(col_ind(:,nN+1:end)-1)*n_test,[1:n_test]')) = inf;
    
% Manifold Embedding
    load([trained_model '/' training_info],'training_set_col_sum',...
         'training_set_invSqrtD','eigVec','eigVal')
    KK = exp(-sqDist_Ny/sigma_Ny/sigma_Ny);
    WW = bsxfun(@rdivide,KK,sum(KK,2).^alpha);
    WW = bsxfun(@rdivide,WW,training_set_col_sum.^alpha);
    DD = sum(WW,2)';
    sqrtD = sqrt(DD);
    invSqrtD = 1./sqrtD;
    LL = bsxfun(@times,WW,training_set_invSqrtD);
    LL = bsxfun(@times,LL,invSqrtD');
    eigVec_test = bsxfun(@rdivide,LL*eigVec,eigVal');
    
% f(x) fitting and reading
    c_coeff_info = ['c_coeff_info_nS' num2str(nS) ...
                    '_nN' num2str(nN) ...
                    '_sigma' num2str(sigma_Ny,'%.4f') ...
                    '_nEigs' num2str(nEigs) '.mat'];
    load([trained_model '/' c_coeff_info],'my_c_coeff') 
    for j_eta=1:num_eta
      eta = eta_list(j_eta);
      my_c_coeff(eigVal<eigVal(1)/eta) = 0;
      fitted = eigVec_test*my_c_coeff';
      fit_table(j_sigma,j_eta,:) = fitted;
    end % j_eta
  end % j_sigma
  
  single_visit_readout_candidate = reshape(fit_table(:,:,1),[],1);
  h = figure;
  hsp = subplot(1,1,1);
  my_xlabel = 'GA Predicted (Days)';
  my_ylabel = 'Number Of Times';
  my_title = 'GA Prediction Histogram';
  param = [];
  param.bar_text_fontSize = 1;
  plotRF_integer_bar_chart(hsp,single_visit_readout_candidate,my_xlabel,my_ylabel,my_title,param)
  
  [n,edges] = histcounts(single_visit_readout_candidate,'binMethod','integers');
  x = 0.5*(edges(1:end-1)+edges(2:end));
  
  [max_n,ind] = max(n);
  min_x = min(x);
  max_x = max(x);
  x_at_max_n = x(ind);
  if ~(max_n>peak_height_threshold)
    my_xTick = [min_x max_x];
    predicted_GA = nan;
  else
    hold on
    bar(x_at_max_n,max_n,'r')
    hold off
    my_xTick = [min_x x_at_max_n max_x];
    if (x_at_max_n-min_x<3), my_xTick = setxor(my_xTick,min_x); end
    if (max_x-x_at_max_n<3), my_xTick = setxor(my_xTick,max_x); end
    my_xTick = unique([my_xTick,x_at_max_n]);
    predicted_GA = x_at_max_n;
  end
  set(hsp,'xTick',my_xTick)
  if isnan(predicted_GA)
    mesg = 'An estimate with accuracy better than the typical LMP-based estimates requires additional data.';
  else
    mesg = ['Fetal GA estimated to be ' num2str(predicted_GA) ' days.'];
  end
  disp(mesg)
% end manifold_GA
