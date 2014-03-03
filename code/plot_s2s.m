function plot_s2s(DCM,P)
%画出F中点P的sita-sigma曲线
F = double(DCM);
Sigma_min = 0.1;
Sigma_max = 2.0;
Sigma_step = 0.05;
x_Sigma = linspace(Sigma_min,Sigma_max,39);
x = P(1);
y = P(2);
i = 1;
for Sigma = Sigma_min : Sigma_step : Sigma_max
    %debug
    %disp(Sigma)
    %enddebug
    Gx = myGausx(Sigma);
    Gy = myGausy(Sigma);
    Fx = int32(imfilter(F,Gx));
    Fy = int32(imfilter(F,Gy));
	if Fy(x,y) >= 0
        Sitatemp = acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
    else
        Sitatemp = 2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
    end
    y_Sita(i) = Sitatemp;
    i = i + 1;
end
figure, plot(x_Sigma,y_Sita)