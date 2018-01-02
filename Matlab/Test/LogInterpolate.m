function out = LogInterpolate(x, x1, x2, y, y1, y2)
%  (y-y1)/(y2-y1) = (log(x)-log(x1))/(log(x2)-log(x1))
    if(isempty(y)) % solve for y
        out = (log2(x./x1)./log2(x2./x1))*(y2-y1)+y1;
    else % solve for x
        out = 2.^((y-y1)/(y2-y1).*(log2(x2)-log2(x1)) + log2(x1));
    end
end