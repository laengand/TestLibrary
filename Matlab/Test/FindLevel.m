function xLevelList = FindLevel(x, y, yLevel)
    % FindLevel
    %     Find the
%         fs = 10;
%         x = 1:1/fs:fs;
%         y = 5*sin(2*pi*x);
%         ylevel = 2;
    
    xLevelList = [];
    idx = y < yLevel;
    
    for i = 1:length(idx)-1
        if(idx(i) ~= idx(i+1))
            
            %% polyfit
            xPol = x(i-1:i+2);
            yPol = y(i-1:i+2);
            pfit = polyfit(xPol,yPol,3);
            % y = ax^2 + bx + c
            % pfit = [a b c]
            % solve for x 
            xRoots = roots([pfit(1:end-1) pfit(end)-yLevel]);
            xLevel = xRoots(x(i)< xRoots & xRoots < x(i+1));
            xLevelList = [xLevelList xLevel]; %#ok

        end
    end
end
