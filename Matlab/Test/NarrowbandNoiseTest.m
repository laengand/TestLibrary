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
        fcLowerMin = fm/2^(1/4); % Minimum value for the lower cut-off frequency
        fcLowerMax = fm/2^(1/6); % Maxmum value for the lower cut-off frequency
        fcUpperMin = fm*2^(1/6); % Minimum value for the upper cut-off frequency
        fcUpperMax = fm*2^(1/4); % Maximum value for the upper cut-off frequency
        
        %% Test if fcLower and fcUpper is within the given bounaries
        
        fig = figure('Visible', figureVisibleOption);
        lineFft = semilogx(x,y);
        
        hold(lineFft.Parent,'on')
        
        title(['Narrowband Noise ' num2str(fm) ' Hz'])
        xlabel('Hz')
        ylabel('dB')
        numData = length(x(x > fcLowerMin & x < fcUpperMax));

        % smoothing window width is 2^(1% of data points within the fc limits, fcLowerMin and fcUpperMax)
        % no mathematical proof of why this is a good window size 
        span = 2^ceil(numData*0.01); % span should be odd
        if(span == 1)
            span = 3;
        elseif rem(span,2) == 0     % if not odd, add 1
            span = span + 1;
        end
        
        % smooth the data set 
        y = smooth(y, span);
        
        % Note: The smoothing command returns a column vector no matter if 
        % the input is a row or column vector. We change the y vectors 
        % dimensions to match the x vector
        
        yRow = size(y);
        xRow = size(x);
        
        if(yRow ~= xRow)
            y = y.';
        end
%         y = smooth(y, 'sgolay');
        
        % draw the smoothed line
        line(x, y, 'Color', 'black', 'LineWidth', 2);
        [yMax, yMaxIdx] = max(y);
        yMin = min(y);
        
        f3dB = FindLevel(x,y,yMax-3);
                
        % draw the determined cut-off frequencies 
        for i = 1:length(f3dB)
            line(lineFft.Parent, f3dB(i),yMax-3,'marker','.', 'color','r')
            line(lineFft.Parent, [f3dB(i) f3dB(i)], [yMin, yMax], 'Color', 'black');
            text(lineFft.Parent, double(f3dB(i)), double(yMax), ['f_' num2str(i)]);
        end
        fcLower = f3dB(1);
        fcUpper = f3dB(2);
        
        fcLowerIdx = find(yMax - y(1:yMaxIdx-1)>= 3,1, 'last');
        fcUpperIdx = yMaxIdx + find(yMax - y(yMaxIdx+1:end) >= 3, 1, 'first');
        
        % draw the band limits
        line([fcLowerMin fcLowerMin], [yMin yMax], 'Color', 'red');
        line([fcLowerMax fcLowerMax], [yMin yMax], 'Color', 'red');
        line([fcUpperMin fcUpperMin], [yMin yMax], 'Color', 'red');        
        line([fcUpperMax fcUpperMax], [yMin yMax], 'Color', 'red');
        
        
        if(fcLower >=fcLowerMin && fcLower <= fcLowerMax)
            chList.fcLowerValid = true;
        end
        
        if(fcUpper >=fcUpperMin && fcUpper <= fcUpperMax)
            chList.fcUpperValid = true;
        end
        
        
        %% Test if the slope is at least -12 dB pr.octave when outside the fc bounderies
        [~,fcLowerMinIdx] = min(abs(fcLowerMin-x)); % find index of the data point which is closest to the lower cut-off frequency minimum limit
                
        oc = 3;
        f1 = x(fcLowerMinIdx)/2^oc; % freq 3 octave lower
        f2 = x(fcLowerMinIdx);
        
        y1 = -12*oc+y(fcLowerIdx);
        y2 = y(fcLowerIdx);
        
        ocXLowerIdx = (x >= f1) & (x <= f2);
        ocXLower = x(ocXLowerIdx);
        ocYLower = LogInterpolate(ocXLower, f1, f2, [], y1, y2);
        ocYLowerData = y(ocXLowerIdx);
        
        if(all(ocYLowerData <= ocYLower))
            chList.lowerSlopeValid = true;
        end
        validPoints = ocYLowerData < ocYLower;
        
        line(ocXLower(validPoints), ocYLowerData(validPoints), 'Color', 'green', 'LineWidth', 2);
        line(ocXLower(~validPoints), ocYLowerData(~validPoints), 'Color', 'red', 'LineWidth', 2);

        [~, fcUpperMaxIdx] = min(abs(fcUpperMax-x)); % find index of the data point which is closest to the upper cut-off frequency maximum limit
        
        f1 = x(fcUpperMaxIdx);
        f2 = x(fcUpperMaxIdx)*2^oc; % freq 3 octaves higher
        
        y1 = y(fcUpperIdx);
        y2 = -12*oc+y(fcUpperIdx);
        
        ocXUpperIdx = (x >= f1) & (x <= f2); 
        ocXUpper = x(ocXUpperIdx);
        ocYUpper = LogInterpolate(ocXUpper, f1, f2, [], y1, y2);
        ocYUpperData = y(ocXUpperIdx);
        validPoints = ocYUpperData < ocYUpper;
        
        line(ocXUpper(validPoints), ocYUpperData(validPoints), 'Color', 'green', 'LineWidth', 2);
        line(ocXUpper(~validPoints), ocYUpperData(~validPoints), 'Color', 'red', 'LineWidth', 2);

        if(all(y(ocXUpperIdx) <= ocYUpper))
            chList.upperSlopeValid = true;
        end
        
        line(ocXLower, ocYLower , 'Color', 'blue');
        line(ocXUpper, ocYUpper , 'Color', 'blue');

        %% Test that the amplitude is at least -35 dB relative to the amplitude of the center frequency       
        line([x(find(x > 0, 1, 'first')) x(end)], [yMax yMax], 'Color', 'blue', 'LineWidth', 2);
        line([x(find(x > 0, 1, 'first')) x(end)], [yMax-35 yMax-35], 'Color', 'blue', 'LineWidth', 2);
        
        xIdx = x < x(fcLowerMinIdx)/2^oc; % indices of x with a frequency lower than 3 octaves
                
        if(all(y(xIdx) - yMax <= -35 ))
            chList.lowerLevel35dBValid = true;
        end

        xIdx = x > x(fcUpperMaxIdx)*2^oc; % indices of x with a frequency higher than 3 octaves
        if(all(y(xIdx) - yMax <= -35 ))
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
        DisplayException(ex)
    end
    
end
