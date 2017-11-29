function [tf, chList, fig] = WhiteNoiseTest (tolerance, fLow, fHigh, x, y, figureVisibleOption)
    tf = false;
    chList.level = false;
    
    xStartIdx = find(x <= fLow, 1, 'last');
    xEndIdx = find(x >= fHigh, 1, 'first');
    
    average = mean(y(xStartIdx:xEndIdx));
    fig = figure('Visible', figureVisibleOption);
    lineFft = semilogx(x,y);
    
    line([x(xStartIdx) x(xEndIdx)], [average average] + tolerance, 'Color','r');
    line([x(xStartIdx) x(xEndIdx)], [average average] - tolerance, 'Color','r');
    
    if(abs(y(xStartIdx:xEndIdx) - average) <= 3)
        chList.level = true;
        tf = true;
    end
    
    
end

