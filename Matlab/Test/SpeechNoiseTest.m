function [tf, chList, fig] = SpeechNoiseTest(tolerance, fFlatLow, fFlatHigh, fSlopeLow, fSlopeHigh, x, y, figureVisibleOption)
    %% SpeechNoiseTest
    tf = false;
    chList.shapeValid = false;
    fig = figure('Visible', figureVisibleOption);
    try
        windowFlat = x >= fFlatLow & x <= fFlatHigh;
        windowSlope = x >= fSlopeLow & x <= fSlopeHigh;
        len = length(x(windowFlat | windowSlope));
        yRef(1:len) = 0;
        
        y1 = 0;
        y2 = -12;
        
        x1 = fSlopeLow;
        x2 = fSlopeLow*2;
        
        xRef = x(windowFlat | windowSlope);
        
        if(size(y) ~= size(yRef))
            yRef = yRef.';
            xRef = xRef.';
        end

        yRef(end-length(x(windowSlope))+1:end) = LogInterpolate(x(windowSlope), x1, x2, [], y1, y2);
        
        lineFft = semilogx(x, y);
        title('Speech Noise')
        xlabel('Hz')
        ylabel('dB')
        
        %% fit the reference curve to the dataset
        yOffset = CurveFit(x, y, xRef, yRef);
        yRef = yRef + yOffset;
        line(lineFft.Parent, xRef, yRef + tolerance, 'Color','r');
        line(lineFft.Parent, xRef, yRef - tolerance, 'Color','r');
        line(lineFft.Parent, xRef, yRef, 'Color','r');
        
        if(abs(y(windowFlat | windowSlope)-yRef) < tolerance)
            chList.shapeValid = true;
            tf = true;
        end
        
    catch ex
        DisplayException(ex)
    end
end

