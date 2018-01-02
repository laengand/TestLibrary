function [tf, chList, fig] = PediatricNoiseTest(fm, x, y, figureVisibleOption)
    %% Pediactric noise test
    %                     BW
    %                 f1/иииии\f2
    %                  /   ^   \
    %                 /    |    \
    %                /     |     \  100 dB/octave
    %               /      |      \
    %              / 60 dB |       \
    %             /        |        \
    %            /         |         \
    %     lower /          v          \ upper
    %                      fm
    %
    if(nargin < 4)
        figureVisibleOption = 'on';
    end
    
    chList = struct(...
        'f1Valid', false, ...
        'f2Valid', false, ...
        'lowerSlopeValid', false, ...
        'upperSlopeValid', false ... 
    );
    tf = false;
    
    % remove inf values
    infTF = isinf(y);
    y = y(~infTF);
    x = x(~infTF);
    
    %% bandwidth check
    fig = figure('Visible', figureVisibleOption);
    ph = semilogx(x, y);
    title(['Single-Sided Amplitude Spectrum ' num2str(fm) ' Hz'])
    xlabel('Hz')
    ylabel('dB')
    hold(ph.Parent, 'on');
    
    [yMax, yMaxIdx ] = max(y);
    yMin = min(y);
    f3dB = FindLevel(x,y,yMax-3);
    
    f1 = f3dB(1);
    f2 = f3dB(2);
    % draw the determined cut-off frequencies
    for i = 1:length(f3dB)
        line(f3dB(i),yMax-3,'marker','.', 'color','r')
        line(ph.Parent, [f3dB(i) f3dB(i)], [yMin, yMax], 'Color', 'black');
        text(ph.Parent, double(f3dB(i)), double(yMax), ['f_' num2str(i)]);
    end
    
    freq = [    80,  125,  160,  200,  250,   315,  400,  500,   630,  750,    800, 1000,  1250, 1500,  1600, 2000,   2500, 3000,   3150, 4000, 5000, 6000, 6300, 8000, 9000, 10000, 11200, 12500, 14000, 16000];
    bwPct = [ 0.29, 0.29, 0.29, 0.29, 0.29, 0.277, 0.26, 0.24, 0.219, 0.20, 0.1944, 0.17, 0.149, 0.13, 0.126, 0.11, 0.0984, 0.09, 0.0886, 0.08, 0.08, 0.08, 0.08, 0.08, 0.08,  0.08,  0.08,  0.08,  0.08,  0.08];
    
    bwPolyfit = polyfit(log10(freq), bwPct, 7);
    bwPct = polyval(bwPolyfit, log10(fm));
    
    % Determine the bandwidth based on the center frequency 
    % bw*fm = f2-f1
    % fm = sqrt(f1*f2)
    %     
    % fm^2     = f1*f2
    % fm^2/f1  = f2
    %
    % bw*fm    = (fm^2/f1)-f1
    % bw*fm*f1 = fm^2 - f1^2
    %
    % f1^2 + bw*fm*f1 - fm^2 = 0 
    
    p = [1 fm*bwPct -fm^2];
    froot = sort(abs(roots(p)));

    % tolerance (based on narrowband bandlimits, see standard 60645-1 й IEC:2012)
    % tolerance = (lowerLimit - upperLimit) / ((lowerLimit + upperLimit)/2)/2
    tolerance = ((2^(1/4) - 2^(1/6))/((2^(1/6) + 2^(1/4))/2))/2;
    f1Min = froot(1)*(1-tolerance); % Minimum value for the lower cut-off frequency
    f1Max = froot(1)*(1+tolerance); % Maxmum value for the lower cut-off frequency
    f2Min = froot(2)*(1-tolerance); % Minimum value for the upper cut-off frequency
    f2Max = froot(2)*(1+tolerance); % Maximum value for the upper cut-off frequency
        
    % draw the band limits
    line(ph.Parent, [f1Min f1Min], [yMin yMax], 'Color', 'red');
    line(ph.Parent, [f1Max f1Max], [yMin yMax], 'Color', 'red');
    line(ph.Parent, [f2Min f2Min], [yMin yMax], 'Color', 'red');
    line(ph.Parent, [f2Max f2Max], [yMin yMax], 'Color', 'red');
    
    
        
    % validate the the cut-off frequecies 
    if(f1 >= f1Min && f1 <= f1Max)
        chList.f1Valid = true;
    end
    
    if(f2 >= f2Min && f2 <= f2Max)
        chList.f2Valid = true;
    end
    
    %% 100 dB/octave slope for the first 60 dB
    lower60dBLevelIdx = find(yMax - y(1:yMaxIdx-1) >= 60,1, 'last');
    upper60dBLevelIdx = yMaxIdx + find(yMax - y(yMaxIdx+1:end) >= 60,1, 'first');
    if(isempty(lower60dBLevelIdx) || isempty(upper60dBLevelIdx))
        return;
    end
    % lower
    oc1 = 0;
    y1 = y(lower60dBLevelIdx);
    y2 = yMax;
    
    oc2 = (y2-y1)/-100 + oc1;
    x1 = f1*2^oc2;
    x2 = f1;
    
    [xLowerSlope, yLowerSlope, yLowerSlopeData] = GetSlopeData(x, y, x1, x2, y1, y2);
    
    validPoints = yLowerSlopeData <= yLowerSlope;
    if(all(validPoints))
        chList.lowerSlopeValid = true;
    end
    
    DrawValidSlopes(ph.Parent, xLowerSlope, yLowerSlopeData, validPoints)      
    semilogx(ph.Parent, xLowerSlope, yLowerSlope, 'Color', 'blue')

    % upper
    oc1 = 0;
    y1 = yMax;
    y2 = y(upper60dBLevelIdx);
    
    oc2 = (y2-y1)/-100 + oc1;
    x1 = f2;
    x2 = f2*2^oc2;
    
    [xUpperSlope, yUpperSlope, yUpperSlopeData] = GetSlopeData(x, y, x1, x2, y1, y2);
    
    validPoints = yUpperSlopeData <= yUpperSlope;
    if(all(validPoints))
        chList.upperSlopeValid = true;
    end
    
    DrawValidSlopes(ph.Parent, xUpperSlope, yUpperSlopeData, validPoints)
    semilogx(ph.Parent, xUpperSlope, yUpperSlope, 'Color', 'blue')
    
    hold(ph.Parent, 'off');
    if( chList.f1Valid && ...
        chList.f2Valid && ...
        chList.lowerSlopeValid && ...
        chList.upperSlopeValid)
        tf = true;
    end
    
end

function [xSlope, ySlope, data] = GetSlopeData(x, y, x1, x2, y1, y2)
    if y1 <= y2
        slopeIdx = (x >= x1) & (x <= x2) & (y >= y1) & (y <= y2);
    else
        slopeIdx = (x >= x1) & (x <= x2) & (y <= y1) & (y >= y2);
    end
    
    xSlope = x(slopeIdx);
    ySlope = LogInterpolate(xSlope, x1, x2, [], y1, y2);
    data = y(slopeIdx);
end

function DrawValidSlopes(ax, x, y, validPoints)
    line(ax, x(validPoints), y(validPoints), 'Color', 'green', 'LineWidth', 2);
    line(ax, x(~validPoints), y(~validPoints), 'Color', 'red', 'LineWidth', 2);
end

