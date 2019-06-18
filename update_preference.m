function pref=update_preference(default_pref,user_pref)
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
  
  pref = default_pref;
  if isempty(user_pref), return, end
  field_to_be_updated = fieldnames(user_pref);
  num_field_to_be_updated = numel(field_to_be_updated);
  for j_field_to_be_updated=1:num_field_to_be_updated
    fieldname = field_to_be_updated{j_field_to_be_updated};
    pref = setfield(pref,fieldname,getfield(user_pref,fieldname));
  end
  
%end function update_preference
