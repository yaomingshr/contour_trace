function bestSigma = no_getSigma(F,ls,hs)
bestSigma = ls;
for x = 1 : size(ls,1)
    for y = 1 : size(ls,2)
        max_val = 0;
        for s = ls(x,y) : 0.1 :hs(x,y)
            Gx = myGausx(s);
            Gy = myGausy(s);
            Fx = int32(imfilter(F,Gx));
            Fy = int32(imfilter(F,Gy));
            if (Fx(x,y) ^ 2 + Fy(x,y) ^2) > max_val
                max_val = Fx(x,y) ^ 2 + Fy(x,y) ^2;
                bestSigma(x,y) = s;
            end
        end
    end
end