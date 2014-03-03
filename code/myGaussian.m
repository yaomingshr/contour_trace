function [gauSita,q,bestSigma] = myGaussian(DCM)
%f = dicomread('D:\�ٶ���\��ҵ���\dicom\IM144.dcm');
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

%�����Ǹ�ͼƬ�;���xy�����෴�����⣬�������������⣬�޸�acos ����ĵ�һ��FxΪFy �Լ�MARK

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
                
                %����ƽ���׶ε�����
                if dcp < Sita_tol 
                    
                    if Sigma_State(x,y) == 0            %�ոս���ƽ���׶�
                        Sigma_State(x,y) = Sigma;
                        gauSita(x,y) = Sitatemp(x,y);
                    else                               %���ѽ���ƽ���׶�
                         if Fy(x,y) >= 0
                            Sitatemp(x,y) = acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                         else
                            Sitatemp(x,y) = 2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                         end
                    end
                                            
                    %������õ�sigmaֵ
                    if (Fx(x,y) ^ 2 + Fy(x,y) ^2) > max_sval(x,y)
                        max_sval(x,y) = Fx(x,y) ^ 2 + Fy(x,y) ^2;
                        bestSigma(x,y) = Sigma;
                    end
                    
                %�����������½��׶�    
                elseif dcp >= Sita_tol
                    
                    %һ���������½��׶�
                   if Sigma_State(x,y) == 0 
                        if Fy(x,y) >= 0
                            Sitatemp(x,y) = acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                        else
                            Sitatemp(x,y) = 2*pi - acos(double(Fx(x,y))/sqrt(double(Fx(x,y)^2 + Fy(x,y)^2)));
                        end
                        
                       %�ո���ƽ�������½�
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



