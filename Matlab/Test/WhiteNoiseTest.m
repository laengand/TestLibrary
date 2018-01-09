function [tf, chList, fig] = WhiteNoiseTest (tolerance, fLow, fHigh, x, y, figureVisibleOption)
    %% WhiteNoiseTest
    % 
    tf = false;
    chList.level = false;
    
    xStartIdx = find(x <= fLow, 1, 'last')+1;
    xEndIdx = find(x >= fHigh, 1, 'first')-1;
    
    average = mean(y(xStartIdx:xEndIdx));
    fig = figure('Visible', figureVisibleOption);
    semilogx(x,y);
    title('White Noise')
    xlabel('Hz')
    ylabel('dB')
    
    line([fLow fHigh], [average average] + tolerance, 'Color','r');
    line([fLow fHigh], [average average] - tolerance, 'Color','r');
    
    if(abs(y(xStartIdx:xEndIdx) - average) <= 3)
        chList.level = true;
        tf = true;
    end
end

