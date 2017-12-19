function [yOffset, e] = CurveFit(x, y, xRef, yRef, stepSize)
    
    
    yOffset = inf;
    e = inf;
    minError = inf;
        
    minYRef = min(yRef);
    maxYRef = max(yRef);
    minY = min(y);
    maxY = max(y);
    
    limit1 = maxY-minYRef;
    limit2 = minY-maxYRef;
    if(isinf(maxYRef) ||isinf(minYRef) || isinf(maxY) || isinf(minY))
        return
    end
    if(limit1 < limit2)
        searchInterval = limit1:stepSize:limit2;
    else
        searchInterval = limit2:stepSize:limit1;
    end
    
    [~,xIdx] = intersect(x,xRef);
    if isrow(x)
        window = false(1,length(x));
    else
        window = false(length(x),1);
    end
    
    window(xIdx) = true;
    
    for i=1:length(searchInterval)
        offset = searchInterval(i);
        testCurve = (yRef + offset);
        
        e(i) = sum((testCurve - y(window)).^2)/length(searchInterval);
        if(e(i) < minError)
            minError = e(i);
            yOffset = offset;
        end
    end
end

