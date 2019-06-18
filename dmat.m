function y = dmat( x1, x2 )
% Copyright (c) 2019 Russell Fung & Abbas Ourmazd. All Rights Reserved.

switch nargin
    
    case 1
    
        nX1 = size( x1, 2 );
        y = repmat( sum( x1 .^ 2, 1 ), nX1, 1 );
        y = y - x1' * x1;
        y = y + y';
        y = abs( y + y' ) / 2; % Iron-out numerical wrinkles

    case 2
        
        nX1 = size( x1, 2 );
        nX2 = size( x2, 2 );
        
        
        y = repmat( sum( x1 .^ 2, 1 )', 1, nX2 );
        y = y + repmat( sum( x2 .^ 2, 1 ), nX1, 1 );
        y = y - 2 * x1' * x2;

end
