function plotRF_integer_bar_chart(hAxis,my_list,xlabelText,ylabelText,titleText,user_pref)
% 
% plotRF_integer_bar_chart(hAxis,my_list,xlabelText,ylabelText,titleText,user_pref)
% 
% produces integer bar charts with a consistent look.
% 
% Input:
%   hAxis: use the output of the subplot command.
%   my_list: data to be plotted.
%   xlabelText, ylabelText: x- and y-labels.
%   titleText: plot title.
%   user_pref: user preference
%            : the following properties can be set ...
%            : bar_color, bar_text_color, bar_text_fontSize, bar_text_offset,
%            : bar_text_label_rotation,
%            : fontSize,
%            : lineWidth,
%            : suppressed_bar,
%            : text_label_rotation,
%            : title_fontSize, xlabel_fontSize, ylabel_fontSize,
%            : xlim_offset,
%            : ylim_mult.
% 
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  pref = update_preference(default_preference(),user_pref);
  
  [n,edges] = histcounts(my_list,'binMethod','integers');
  x = 0.5*(edges(1:end-1)+edges(2:end));
  y = n;
  empty_bar = find(y==0);
  x(empty_bar) = [];
  y(empty_bar) = [];
  num_suppressed_bar = numel(pref.suppressed_bar);
  suppressed_bar = nan(num_suppressed_bar,2);
  for j_suppressed_bar=1:num_suppressed_bar
    % suppressed bars are suppressed so as not to affect the overall scaling
    suppressed_x = pref.suppressed_bar(j_suppressed_bar);
    if ismember(suppressed_x,x)
      suppressed_y = y(x==suppressed_x);
      suppressed_bar(j_suppressed_bar,:) = [suppressed_x,suppressed_y];
      y(x==suppressed_x) = 0;
    end
  end
  h_bar = bar(x,y,'faceColor',pref.bar_color);
  ymax = max(y);
  xmin = min(x);
  xmax = max(x);
  set(hAxis,'xlim',[xmin-pref.xlim_offset,xmax+pref.xlim_offset],'ylim',[0,ymax*pref.ylim_mult])
  set(hAxis,'lineWidth',pref.lineWidth,'fontSize',pref.fontSize)
  num_bar = numel(x);
  for j_bar=1:num_bar
    if ismember(x(j_bar),suppressed_bar(:,1)), continue, end
    text(x(j_bar),y(j_bar)+pref.bar_text_offset*ymax,num2str(y(j_bar)),...
      'fontSize',pref.bar_text_fontSize,'color',pref.bar_text_color,...
      'horizontalAlignment',pref.bar_text_horizontalAlignment,...
      'rotation',pref.bar_text_label_rotation)
  end
  for j_suppressed_bar=1:num_suppressed_bar
    suppressed_x = suppressed_bar(j_suppressed_bar,1);
    suppressed_y = suppressed_bar(j_suppressed_bar,2);
    text(suppressed_x,pref.bar_text_offset*ymax,num2str(suppressed_y),...
      'fontSize',pref.bar_text_fontSize,'color',pref.bar_text_color,...
      'horizontalAlignment',pref.bar_text_horizontalAlignment,...
      'rotation',pref.bar_text_label_rotation)
  end
  if isfield(pref,'text_label')
    if ~isempty(pref.text_label)
      set(hAxis,'xTickLabel',pref.text_label)
    end
  end
  set(hAxis,'xTickLabelRotation',pref.text_label_rotation)
  xlabel(xlabelText,'fontSize',pref.xlabel_fontSize)
  ylabel(ylabelText,'fontSize',pref.ylabel_fontSize)
  title(titleText,'fontSize',pref.title_fontSize)
  
%end function plotRF_integer_bar_chart

function pref=default_preference()
  pref.bar_color = 'b';
  pref.bar_text_color = 'r';
  pref.bar_text_fontSize = 15;
  pref.bar_text_offset = 0.05;
  pref.bar_text_horizontalAlignment = 'center';
  pref.bar_text_label_rotation = 0;
  pref.fontSize = 20;
  pref.lineWidth = 2;
  pref.suppressed_bar = [];
  pref.text_label_rotation = 0;
  pref.title_fontSize = 20;
  pref.xlabel_fontSize = 20;
  pref.ylabel_fontSize = 20;
  pref.xlim_offset = 1;
  pref.ylim_mult = 1.1;
%end function default_preference
