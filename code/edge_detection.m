function new_g = edge_detection(DCM,g,sita,sigma)
%利用高斯来进行
cell_n = {[1,0],[-1,0];     %(0-pi/8)
          [1,1],[-1,-1];
          [0,1],[0,-1];
          [-1,1],[1,-1];
          [-1,0],[1,0];
          [-1,-1],[1,1];
          [0,-1],[0,1];
          [1,-1],[-1,1];
        };
edge_g = find(g == 1);
Fimg = double(DCM);
new_g = zeros(size(g));
for i = 1 : size(edge_g,1)
	[x,y] = ind2sub(size(g),edge_g(i));
    Gx = myGausx(sigma(x,y));
    Gy = myGausx(sigma(x,y));
	delta_Gx = int32(imfilter(Fimg,Gx));
    delta_Gy = int32(imfilter(Fimg,Gy));
    %近似取得法线方向上的点
    if (sita(x,y) >= 0) & (sita(x,y) < pi/8) 
        ahead = [x,y] + cell_n{1,1};
        back = [x,y] +  cell_n{1,2};
    elseif (sita(x,y) >= pi/8) & (sita(x,y) < pi*3/8)
        ahead = [x,y] + cell_n{2,1};
        back = [x,y] +  cell_n{2,2};
    elseif (sita(x,y) >= pi*3/8) & (sita(x,y) < pi*5/8)
        ahead = [x,y] + cell_n{3,1};
        back = [x,y] +  cell_n{3,2};
    elseif (sita(x,y) >= pi*5/8) & (sita(x,y) < pi*7/8)
        ahead = [x,y] + cell_n{4,1};
        back = [x,y] +  cell_n{4,2};
	elseif (sita(x,y) >= pi*7/8) & (sita(x,y) < pi*9/8)
        ahead = [x,y] + cell_n{5,1};
        back = [x,y] +  cell_n{5,2};
	elseif (sita(x,y) >= pi*9/8) & (sita(x,y) < pi*11/8)
        ahead = [x,y] + cell_n{6,1};
        back = [x,y] +  cell_n{6,2};
	elseif (sita(x,y) >= pi*11/8) & (sita(x,y) < pi*13/8)
        ahead = [x,y] + cell_n{7,1};
        back = [x,y] +  cell_n{7,2};
	elseif (sita(x,y) >= pi*13/8) & (sita(x,y) < pi*15/8)
        ahead = [x,y] + cell_n{8,1};
        back = [x,y] +  cell_n{8,2};
	elseif (sita(x,y) >= pi*15/8) & (sita(x,y) <= pi*16/8)
        ahead = [x,y] + cell_n{1,1};
        back = [x,y] +  cell_n{1,2};
    end
  
    
    
    %将sita值转换成法线向量
    if sita(x,y) <= pi
        n(1) = cos(sita(x,y));
        n(2) = sqrt(1 - n(1)^2);
    else
        tempsita = 2*pi - sita(x,y);
        n(1) = cos(sita(x,y));
        n(2) = - sqrt(1 - n(1)^2);
    end
    
    ahead_x = myGausx(sigma(ahead(1),ahead(2)));
    ahead_y = myGausx(sigma(ahead(1),ahead(2)));
	delta_aheadx = int32(imfilter(Fimg,ahead_x));
    delta_aheady = int32(imfilter(Fimg,ahead_y));
    
	back_x = myGausx(sigma(back(1),back(2)));
    back_y = myGausx(sigma(back(1),back(2)));
	delta_backx = int32(imfilter(Fimg,back_x));
    delta_backy = int32(imfilter(Fimg,back_y));
    
    gcount(1) = delta_backx(back(1),back(2))*n(1) + delta_backy(back(1),back(2))*n(2);
    gcount(2) = delta_Gx(x,y)*n(1) + delta_Gy(x,y)*n(2);
    gcount(3) = delta_aheadx(ahead(1),ahead(2))*n(1) + delta_aheady(ahead(1),ahead(2))*n(2);
    
    %debug
%     if x == 173 & y == 249
%         disp('a')
%     end
    %end_debug
    
    max_index = find(gcount == max(gcount));
    
%     if size(max_index,2) ~= 1
%         max_index = max_index(1);
%     end

    %debug
%     if x == 179 & y ==262
%         disp('a')
%     end
    %enddebug
    
    if max_index == 1
        new_g(back(1),back(2)) = 1;
    elseif max_index == 2
        new_g(x,y) = 1;
    elseif max_index == 3
        new_g(ahead(1),ahead(2)) = 1;
    end
    
end
    