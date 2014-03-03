function res = grad_magnitudc(F)
%¼ÆËãÌÝ¶È·ù¶È
res = F;
P = padarray(F,[1,1],0,'both');
tempSize = size(F);
pSize = tempSize + 1;
for x = 2 : pSize(1)
    for y = 2 : pSize(2)
        p0 = abs(P(x,y+1) - P(x,y-1));
        p45 = abs(P(x-1,y+1) - P(x+1,y-1));
        p90 = abs(P(x-1,y) - P(x+1,y));
        p135 = abs(P(x-1,y-1) - P(x+1,y+1));
        res(x-1,y-1) = (p0 + p45 + p90 +p135) / 4;
    end
end

bw = edge(F,'canny');
for i = 1 : size(F,1)
    for j = 1 : size(F,2)
        if bw(i,j) == 1
            res(i,j) = res(i,j) + 1000;
        end
    end
end
    
    
    