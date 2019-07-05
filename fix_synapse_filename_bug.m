% fix_synapse_filename_bug
% 
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
  
  trained_model = './trained_model';
  trained_model_entry = dir(trained_model);
  num_trained_model_entry = length(trained_model_entry);
  for j_trained_model_entry=1:num_trained_model_entry
    if (trained_model_entry(j_trained_model_entry).isdir)
      model_name = trained_model_entry(j_trained_model_entry).name;
      model_item = dir([trained_model '/' model_name]);
      num_model_item = length(model_item);
      for j_model_item=1:num_model_item
        current_model_item_name = model_item(j_model_item).name;
        i0 = strfind(current_model_item_name,'(');
        if ~isempty(i0)
          i1 = strfind(current_model_item_name,')');
          new_model_item_name = current_model_item_name;
          new_model_item_name(i0:i1) = [];
          movefile([trained_model '/' model_name '/' current_model_item_name],...
                   [trained_model '/' model_name '/' new_model_item_name]);
        end
      end
    end
  end
