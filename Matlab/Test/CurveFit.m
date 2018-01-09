function [yOffset, e] = CurveFit(x, y, xRef, yRef)
    %% CurveFit
    % This function attempt to will fit a reference curve [xRef,yRef] to a
    % dataset [x,y], by sweeping the reference curve along the y-axis. The
    % function assumes that x and xRef have the same resolution, and that
    % they contain overlapping values
        
    [~,xIdx] = intersect(x, xRef);
    if isrow(x)
        window = false(1,length(x));
    else
        window = false(length(x),1);
    end
    
    window(xIdx) = true;
               
    yOffset = sum((y(window) - yRef))/length(yRef);
    e = (y(window) - (yRef + yOffset) ).^2;
end

