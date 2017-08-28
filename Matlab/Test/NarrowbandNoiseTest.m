function [tf, chList, fig] = NarrowbandNoiseTest (fm, x, y, figureVisibleOption)
    %% Narrowband noise test
    % Tests if the given data represents narrowband noise according to
    % standard 60645-1 © IEC:2012
    
    if(nargin < 4)
        figureVisibleOption = 'on';
    end
    
    if(x < 0)
        error('Value of x must be non-negative')
    end
    
    %% Initialize return values
    chList = struct(...
        'fcLowerValid' ,false, ...
        'fcUpperValid' ,false, ...
        'lowerSlopeValid' ,false, ...
        'upperSlopeValid' ,false, ...
        'lowerLevel35dBValid', false, ...
        'upperLevel35dBValid', false ...
        );
    
    tf = false;
    try
        %% remove inf values
        infTF = isinf(y);
        y = y(~infTF);
        x = x(~infTF);
        
        %% Compute bounds of cut-off frequencies
        
        [yMax , yMaxIdx] = max(y);
        yMin = min(y);
        
%         fm = x(yMaxIdx); % Center frequency
        fcLowerMin = fm/2^(1/4); % Minimum value for the lower cut-off frequency
        fcLowerMax = fm/2^(1/6); % Maxmum value for the lower cut-off frequency
        fcUpperMin = fm*2^(1/6); % Minimum value for the upper cut-off frequency
        fcUpperMax = fm*2^(1/4); % Maximum value for the upper cut-off frequency
        
        %% Test if fcLower and fcUpper is within the given bounaries
        
%         span = ceil(fm/100/res); % span should be odd
        numData = length(x);
        span = ceil(numData/100); % span should be odd
        if rem(span,2) == 0     % if not odd, add 1
            span = span + 1;
        end
        % smooth the data set
        xSmooth = x;
        ySmoothA = smooth(y,span);
        ySmoothB = y;
        ySmoothB(end:-1:1) = smooth(y(end:-1:1), span);
        
        ySmooth = mean([ySmoothA ySmoothB],2);
        
        
        [ySmoothMax, ySmoothMaxIdx] = max(ySmooth);
        
        fcLowerIdx = find(ySmoothMax - y(1:ySmoothMaxIdx-1)>= 3,1, 'last');
        fcLower = xSmooth(fcLowerIdx);
        fcUpperIdx = ySmoothMaxIdx + find(ySmoothMax - y(ySmoothMaxIdx+1:end) >= 3, 1, 'first');
        fcUpper = xSmooth(fcUpperIdx);
        
        fig = figure('Visible', figureVisibleOption);
        lineFft = semilogx(x,y);
        
        hold(lineFft.Parent,'on')
        line(xSmooth, ySmooth, 'Color', 'black', 'LineWidth', 2);
        title(['Single-Sided Amplitude Spectrum ' num2str(fm)])
        xlabel('Hz')
        ylabel('dB')
        
        resolution = numel(x);
        
        lineFcLowerMinX = ones(resolution+1,1)*fcLowerMin;
        lineFcLowerMinY = yMin:(yMax-yMin)/resolution:yMax;
                
        line(lineFcLowerMinX ,lineFcLowerMinY , 'Color', 'red');
        
        lineFcLowerMaxX = ones(resolution+1,1)*fcLowerMax;
        lineFcLowerMaxY = yMin:(yMax-yMin)/resolution:yMax;
        line(lineFcLowerMaxX, lineFcLowerMaxY, 'Color', 'red');
        
        lineFcUpperMinX = ones(resolution+1,1)*fcUpperMin;
        lineFcUpperMinY = yMin:(yMax-yMin)/resolution:yMax;
        line(lineFcUpperMinX, lineFcUpperMinY, 'Color', 'red');
        
        lineFcUpperMaxX = ones(resolution+1,1)*fcUpperMax;
        lineFcUpperMaxY = yMin:(yMax-yMin)/resolution:yMax;
        line(lineFcUpperMaxX, lineFcUpperMaxY, 'Color', 'red');
        
        line([fcLower fcLower], [yMin,yMax], 'Color', 'black');
        text(fcLower, yMax, 'fc_{Lower}');
        
        line([fcUpper fcUpper], [yMin,yMax], 'Color', 'black');
        text(fcUpper, yMax, 'fc_{Upper}');
        
        
        
        if(fcLower >=fcLowerMin && fcLower <= fcLowerMax)
            chList.fcLowerValid = true;
        end
        
        
        if(fcUpper >=fcUpperMin && fcUpper <= fcUpperMax)
            chList.fcUpperValid = true;
        end
        
        
        %% Test if the slope is at least -12 dB pr.octave when outside the fc bounderies
        [~,ILowerMin] = min(abs(fcLowerMin-x));
        oc = 0:0.01:3;
        
        ocYLower = -12*oc+y(ILowerMin);
        ocXLower = x(ILowerMin)./2.^oc;
        
        [~,IUpperMax] = min(abs(fcUpperMax-x));
        oc = 0:0.01:3;
        
        ocYUpper = -12*oc+y(IUpperMax);
        ocXUpper = x(IUpperMax)*2.^oc;
        
        
        lineOcLower = line(ocXLower , ocYLower , 'Color', 'blue');
        lineOcUpper = line(ocXUpper, ocYUpper , 'Color', 'blue');
        lineFft.Parent.XLim = [ocXLower(end) ocXUpper(end)];
        
        
        % convert x-values to log scale inorder to make the octave curves
        % linear. The slope of the octave curve can then easily be compared
        % with the piecewise slopes of the fft curve
        x = log10(x);
        infTF = isinf(x);
        y = y(~infTF);
        x = x(~infTF);
        
        ocXLower = log10(ocXLower);
        ocXUpper = log10(ocXUpper);
        
        slopeOcLower = (ocYLower(1) - ocYLower(end))/(ocXLower(1) - ocXLower(end));
        ocLowerStartIdx = find(x <= ocXLower(end), 1, 'last');
        if(isempty(ocLowerStartIdx))
            ocLowerStartIdx = 1;
        end
        ocLowerEndIdx = ILowerMin;
        
        %     i = ocLowerStartIdx:ocLowerEndIdx;
        
        attempt = 1;
        order = 10;
        s = warning;
        warning('off', 'MATLAB:polyfit:RepeatedPointsOrRescale')
        
        while(attempt < 10)
            try
                p = polyfit(x(ocLowerStartIdx:ocLowerEndIdx),y(ocLowerStartIdx:ocLowerEndIdx), order);
                error(lastwarn);
                break;
            catch ex
                lastwarn('');
                order = order - 1;
                attempt = attempt + 1;
            end
        end
        warning(s);
        
        xp = x(ocLowerStartIdx):0.001:x(ocLowerEndIdx);
        yp = polyval(p,xp);
        i = 2:numel(xp);
        %     slope = (y(i)- y(i-1))./(x(i)- x(i-1));
        slope = (yp(i)- yp(i-1))./(xp(i)- xp(i-1));
        
        lowerSlopeValid = slope > slopeOcLower;
        
        if(all(lowerSlopeValid))
            chList.lowerSlopeValid = true;
        end
        
        
        line(10.^xp(lowerSlopeValid), yp(lowerSlopeValid), 'Color', 'green', 'LineWidth', 2);
        line(10.^xp(~lowerSlopeValid), yp(~lowerSlopeValid), 'Color', 'red', 'LineWidth', 2);
        
        
        slopeOcUpper = (ocYUpper(end) - ocYUpper(1))/(ocXUpper(end) - ocXUpper(1));
        ocUpperStartIdx = IUpperMax;
        ocUpperEndIdx = find(x >= ocXUpper(end), 1, 'first');
        if(isempty(ocUpperEndIdx))
            ocUpperEndIdx = length(x);
        end
        i=ocUpperStartIdx:ocUpperEndIdx;
        
        attempt = 1;
        order = 10;
        s = warning;
        warning('off', 'MATLAB:polyfit:RepeatedPointsOrRescale')
        while(attempt < 10)
            try
                p = polyfit(x(ocUpperStartIdx:ocUpperEndIdx),y(ocUpperStartIdx:ocUpperEndIdx), order);
                error(lastwarn);
                break;
            catch ex
                lastwarn('');
                order = order - 1;
                attempt = attempt + 1;
            end
        end
        warning(s);
        xp = x(ocUpperStartIdx):0.001:x(ocUpperEndIdx);
        yp = polyval(p,xp);
        i = 2:numel(xp);
        
        %     slope = (y(i)- y(i-1))./(x(i)- x(i-1));
        slope = (yp(i)- yp(i-1))./(xp(i)- xp(i-1));
        upperSlopeValid = slope < slopeOcUpper;
        if(all(upperSlopeValid))
            chList.upperSlopeValid = true;
        end
        
        line(10.^xp(upperSlopeValid), yp(upperSlopeValid), 'Color', 'green', 'LineWidth', 2);
        line(10.^xp(~upperSlopeValid) , yp(~upperSlopeValid), 'Color', 'red', 'LineWidth', 2);
        
        %% Test is the amplitude is at least -35 dB relative to the amplitude of the center frequency
        line([10^x(1) 10^x(end)], [yMax yMax] , 'Color', 'blue', 'LineWidth', 2);
        line([10^x(1) 10^x(end)], [yMax-35 yMax-35] , 'Color', 'blue', 'LineWidth', 2);
        
        if(all(y(1:ocLowerStartIdx) - yMax <= -35 ))
            chList.lowerLevel35dBValid = true;
        end
        
        if(all(y(ocUpperEndIdx:end) - yMax <= -35 ))
            chList.upperLevel35dBValid = true;
        end
        
        hold(lineFft.Parent,'off')
        
        if(chList.fcLowerValid && ...
                chList.fcUpperValid && ...
                chList.lowerSlopeValid && ...
                chList.upperSlopeValid && ...
                chList.lowerLevel35dBValid && ...
                chList.upperLevel35dBValid ...
                )
            tf = true;
        end
    catch ex
        ex
    end
end