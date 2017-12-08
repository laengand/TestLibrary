function [tf, chList, fig] = WhiteNoiseTest (tolerance, fLow, fHigh, x, y, figureVisibleOption)
    tf = false;
    chList.level = false;
    
    xStartIdx = find(x <= fLow, 1, 'last');
    xEndIdx = find(x >= fHigh, 1, 'first');
    
    average = mean(y(xStartIdx:xEndIdx));
    fig = figure('Visible', figureVisibleOption);
    lineFft = semilogx(x,y);
    
    line([fLow fHigh], [average average] + tolerance, 'Color','r');
    line([fLow fHigh], [average average] - tolerance, 'Color','r');
    
    if(abs(y(xStartIdx:xEndIdx) - average) <= 3) %% If the resolution of the fft used for the spectrum is too low, the StartIdx might point to a value less than fLow
        chList.level = true;
        tf = true;
    end
    
    
end

