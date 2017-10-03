function y = LogInterpolate(f,f1,f2,y1,y2)
    y = (log2(f/f1)/log2(f2/f1))*(y2-y1)+y1;
end
