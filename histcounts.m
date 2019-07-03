function [n,edges]=histcounts(x,dummy1,dummy2)
%  
% The MATLAB histcounts function is minimally implemented here to allow
% manifold-GA to run in GNU Octave.
%  
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
  
  edge0 = floor(min(x))-0.5;
  edge1 = ceil(max(x))+0.5;
  edges = edge0:1:edge1;
  n = histc(x,edges);
  n(end) = [];
  
