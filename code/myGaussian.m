function [gauSita,q,bestSigma] = myGaussian(DCM)
%f = dicomread('D:\百度云\毕业设计\dicom\IM144.dcm');
F = double(DCM);
imgSize = size(F);

Sigma_min = 0.1;
Sigma_max = 2.0;
Sigma_step = 0.05;
Sigma_State = zeros(imgSize(1),imgSize(2));
l_sigma = zeros(imgSize(1),imgSize(2));
h_sigma = zeros(imgSize(1),imgSize(2));
bestSigma = zeros(imgSize(1),imgSize(2));
q = zeros(imgSize(1),imgSize(2));
Sita_tol = 10*pi/180;
Sitatemp = zeros(imgSize(1),imgSize(2));
gauSita = zeros(imgSize(1),imgSize(2));
max_sval = zeros(imgSize(1),imgSize(2));

%关于那个图片和矩阵xy正好相反的问题，如果最后结果出问题，修改acos 后面的第一个Fx为Fy 自己MARK

for Sigma = Sigma_min : Sigma_step : Sigma_max
%     Gx = fspecial('gaussian',3,Sigma);
%     temp = Gx';
%     temp1 = temp(:,1);
%     temp2 = temp(:,2);
%     temp3 = temp(:,3);
%     Gy = zeros(3,3);
%     Gy(:,1) = temp3;
%     Gy(:,2) = temp2;
%     Gy(:,3) = temp1;
    Gx = myGausx(Sigma);
    Gy = myGausy(Sigma);
    Fx = int32(imfilter(F,Gx));
    Fy = int32(imfilter(F,Gy));
    
    if Sigma == 0.1
        for x = 1:imgSize(1)
            for y = 1:imgSize(2)
                if Fy(x,y) >= 0
                    Sitatemp(x,y) = acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                else
                    Sitatemp(x,y) = 2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                end
            end
        end
    
    else
        for x = 1:imgSize(1)
            for y = 1:imgSize(2)
                if Fy(x,y) >= 0
                    dcp = abs(Sitatemp(x,y) - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2))));
                else
                    dcp = abs(Sitatemp(x,y) - (2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)))));
                end
                
                %处于平滑阶段的曲线
                if dcp < Sita_tol 
                    
                    if Sigma_State(x,y) == 0            %刚刚进入平滑阶段
                        Sigma_State(x,y) = Sigma;
                        gauSita(x,y) = Sitatemp(x,y);
                    else                               %早已进入平滑阶段
                         if Fy(x,y) >= 0
                            Sitatemp(x,y) = acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                         else
                            Sitatemp(x,y) = 2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                         end
                    end
                                            
                    %计算最好的sigma值
                    if (Fx(x,y) ^ 2 + Fy(x,y) ^2) > max_sval(x,y)
                        max_sval(x,y) = Fx(x,y) ^ 2 + Fy(x,y) ^2;
                        bestSigma(x,y) = Sigma;
                    end
                    
                %处于上升或下降阶段    
                elseif dcp >= Sita_tol
                    
                    %一般上升、下降阶段
                   if Sigma_State(x,y) == 0 
                        if Fy(x,y) >= 0
                            Sitatemp(x,y) = acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                        else
                            Sitatemp(x,y) = 2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                        end
                        
                       %刚刚由平滑进入下降
                   else
                        q(x,y) = ((Sigma - 0.1) - (Sigma_State(x,y) - 0.1))/(Sigma_max - Sigma_min);
                        l_sigma(x,y) = Sigma_State(x,y) - 0.1;
                        h_sigma(x,y) = Sigma - 0.1;
                        Sigma_State(x,y) = 0;
                   end
                end
            end
       end
   end
    
end

return;
%bestSigma = getSigma(F,l_sigma,h_sigma);
%d_gauSita = gauSita * 180 / pi;



