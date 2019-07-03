function my_substring=parse_string(my_string,marker0,marker1)
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
  
  i0 = strfind(my_string,'(');
  i1 = strfind(my_string,')');
  my_string(i0:i1) = [];
  i0 = strfind(my_string,marker0)+length(marker0);
  i1 = strfind(my_string,marker1)-1;
  i1(i1<i0) = [];
  i1 = i1(1);
  my_substring = my_string(i0:i1);
% end parse_string
