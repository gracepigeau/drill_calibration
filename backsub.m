function [xb] = backsub(R,y)
    [n,m] = size(R);
    xb = zeros(n,1);
    xb(n) = y(n)/R(n,n);
    for i = (n-1:-1:1)
        xb(i) = (y(i) - R(i,(i+1):n) * xb(i+1:n)) / R(i,i); 
    end