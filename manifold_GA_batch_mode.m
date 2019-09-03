% manifold_GA_batch_mode
% 
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  if ~exist('goldilocks0','var'), goldilocks0 = 18; end
  if ~exist('goldilocks1','var'), goldilocks1 = 32; end
  
  data = csvread ('manifold_ga_example.csv');
  
  % remove first row containing column labels
  data = data(2:end,:);
  
  % which data columns contains subjectID, relative GA, AC(cm), FL(cm), HC(cm)?
  subjectID_col = 1;
  relative_GA_col = 2;
  AC_col = 5;
  FL_col = 6;
  HC_col = 4;
  
  subjectID = data(:,subjectID_col);
  unique_subjectID = unique(subjectID);
  num_subject = numel(unique_subjectID);
  
  manifold_predicted_GA = nan(num_subject,2);
  manifold_predicted_GA(:,1) = unique_subjectID;
  
  batch_mode = true;
  
  for jj_subject=1:num_subject
    my_subjectID = unique_subjectID(jj_subject);
    subject_block = data(find(subjectID==my_subjectID),:);
    subject_block = sortrows(subject_block,relative_GA_col);
    num_visit = size(subject_block,1);
    relative_GA = subject_block(:,relative_GA_col);
    dt_to_latest_visit = relative_GA(end)-relative_GA;
    AC = subject_block(:,AC_col);
    FL = subject_block(:,FL_col);
    HC = subject_block(:,HC_col);
    %%%%%
    % use Papageorghiou Eqn 2 to select good visits
    clear subject_block
    clear relative_GA
    FL_mm = FL*10;
    HC_mm = HC*10;
    logGA_Eq2 = 0.03243*log(HC_mm).^2+0.001644*FL_mm.*log(HC_mm)+3.8130;
    GA_Eq2 = exp(logGA_Eq2);
    good_visit = find((GA_Eq2-goldilocks0*7>-7)&(GA_Eq2-goldilocks1*7<7));
    num_visit = numel(good_visit);
    dt_to_latest_visit = dt_to_latest_visit(good_visit);
    AC = AC(good_visit);
    FL = FL(good_visit);
    HC = HC(good_visit);
    %%%%%
    switch (num_visit)
      case 0,
        reported_GA = nan;
      case 1,
        T = [AC FL HC];
        manifold_GA
        reported_GA = predicted_GA+dt_to_latest_visit;
      otherwise
        T = [AC(1) FL(1) HC(1)
             AC(2) FL(2) HC(2)];
        dt = dt_to_latest_visit(1)-dt_to_latest_visit(2);
        manifold_GA_2_visits
        reported_GA = predicted_GA+dt_to_latest_visit(2);
    end
    manifold_predicted_GA(jj_subject,2) = reported_GA;
  end
  
  csvwrite('manifold_predicted_ga.csv', manifold_predicted_GA);
  
