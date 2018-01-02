function xLevelList = FindLevel(x, y, yLevel)
    %% Find Level
    % FindLevel(x, y, yLevel) finds the x-value(xLevel) corresponding to 
    % yLevel in the dataset given by x,y. The xLevel is found by fitting a 
    % 2nd order polynomial to the 4 dataset values closest to the 
    % (xLevel,yLevel) dataset. If more than 1 xLevel corresponds to the 
    % yLevel, then a vector of xLevels is returned.
    %
    %        y
    %        ^
    %        |
    %        |             (x4,y4)*
    %        |                   /
    %        |                  /
    %        |                 / 
    %        |         (x3,y3)* 
    %        |               /  
    % yLevel |- - - - - - - /     
    %        |             /|
    %        |     (x2,y2)* |
    %        |           /  |
    %        |          /   |
    %        |         /    |
    %        | (x1,y1)*     |
    %        |              |
    %        |              |
    %        ----------------------------------------------> x
    %                       xLevel
    xLevelList = [];
    idx = y < yLevel;
    
    for i = 1:length(idx)-1
        if(idx(i) ~= idx(i+1))
            xPol = x(i-1:i+2);
            yPol = y(i-1:i+2);
            pfit = polyfit(xPol,yPol,2);
            % y = ax^2 + bx + c
            % pfit = [a b c]
            % solve 0 = ax^2 + bx + c-y for x
            xRoots = roots([pfit(1:end-1) pfit(end)-yLevel]);
            xLevel = xRoots(x(i) < xRoots & xRoots < x(i+1));
            xLevelList = [xLevelList xLevel]; %#ok
        end
    end
end
