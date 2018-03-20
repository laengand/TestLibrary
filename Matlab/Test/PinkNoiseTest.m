function [tf, chList, fig] = PinkNoiseTest(tolerance, fLow, fHigh, x, y, figureVisibleOption)
    %% PinkNoiseTest
    % 
    
    tf = false;
    chList.slopeValid = false;
    
    if(nargin < 6)
        figureVisibleOption = 'on';
    end
    
    %% remove inf values
    infTF = isinf(y);
    y = y(~infTF);
    x = x(~infTF);
    
    %% create a reference curve with a slope of -3dB pr. octave
    y1 = 0;
    y2 = -3;
    
    x1 = fLow;
    x2 = fLow*2;
        
    yRef = LogInterpolate(x, x1, x2, [], y1, y2);
    window = (x >= fLow & x <= fHigh);
    
    fig = figure('Visible', figureVisibleOption);
    lineFft = semilogx(x, y);
    title('Pink Noise')
    xlabel('Hz')
    ylabel('dB')
    
    %% fit the reference curve to the dataset
    yOffset = CurveFit(x, y, x(window), yRef(window));
    yRef = yRef + yOffset;
    line(lineFft.Parent, x(window), yRef(window) + tolerance, 'Color','r');
    line(lineFft.Parent, x(window), yRef(window) - tolerance, 'Color','r');
    line(lineFft.Parent, x(window), yRef(window), 'Color','r');
    
    if(abs(y(window)-yRef(window)) < tolerance)
        chList.slopeValid = true;
        tf = true;
    end
end

