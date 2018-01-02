function [tf, chList, fig] = BroadbandNoiseTest(x, y, figureVisibleOption)
    %% BroadbandNoiseTest
    
    tf = false;
    chList.shapeValid = false;
    
    snNominal = SnNominal(x);
    infTF = isinf(snNominal);
    f = x(~infTF);
    resp = y(~infTF);
    
    snNominal = snNominal(~infTF);
    snUpper = SnUpper(f);
    snLower = SnLower(f);
    stepSize = 1;
    
    fig = figure('Visible', figureVisibleOption);
    lineFft = semilogx(f,resp);
    
    lUpper = line(lineFft.Parent, f, snUpper, 'Color','r');
    lLower = line(lineFft.Parent, f, snLower, 'Color','r');
    lNominal = line(lineFft.Parent, f, snNominal, 'Color','r');
    
    window = (f > 200 & f < 5000);
    
    yOffset = CurveFit(f, resp, f(window), snNominal(window));
    
    lUpper.XData = f;
    lUpper.YData = snUpper + yOffset;
    
    lLower.XData = f;
    lLower.YData = snLower + yOffset;
    
    lNominal.XData = f;
    lNominal.YData = snNominal + yOffset;
    
    if(all(resp > (snLower + yOffset) & resp < (snUpper + yOffset)))
        chList.shapeValid = true;
        tf = true;
    end       
end

function snNominal = SnNominal(f)
    snNominal = 10.*log10((f./200).^4./(1+(f./200).^4)*1./(1+(f./900).^2));
end

function snUpper = SnUpper(f)
    if(isrow(f))
        snUpper = zeros(1,length(f));
    else
        snUpper = zeros(length(f),1);
    end
    fBelow200 = f(f<200);
    snUpper(f<200) = 10*log10((fBelow200./200).^2./(1+(fBelow200/200).^2)*1./(1+(fBelow200./900).^2)) + 3;
    
    fAbove200Below5000 = f((f>=200) & (f<=5000));
    snUpper((f>=200) & f<=5000) = SnNominal(fAbove200Below5000) + 3;
    
    snUpper(f>5000) = SnNominal(5000) + 3;
end

function snLower = SnLower(f)
    if(isrow(f))
        snLower = zeros(1,length(f));
    else
        snLower = zeros(length(f),1);
    end
    snLower(f<200) = -inf;
    
    fAbove200Below5000 = f((f>=200) & (f<=5000));
    
    snLower((f>=200) & f<=5000) = SnNominal(fAbove200Below5000) - 3;
    snLower(f>5000) = -inf;
end