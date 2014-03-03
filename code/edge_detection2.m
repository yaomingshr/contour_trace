function new_g = edge_detection2(mag_g,g,sita)
%利用梯度幅值的边缘检测
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
new_g = zeros(size(g));
threshold = 110;
for i = 1 : size(edge_g,1)
	[x,y] = ind2sub(size(g),edge_g(i));
    
	%debug
%     if i == 37
%         disp('a');
%     end
    %enddebug

    %近似取得法线方向上的点
    if (sita(x,y) >= 0) & (sita(x,y) < pi/8) 
        ahead = [x,y] + cell_n{1,1};
        back = [x,y] +  cell_n{1,2};
%         ahead2 = ahead + cell_n{1,1};
%         back2 = back +  cell_n{1,2};
    elseif (sita(x,y) >= pi/8) & (sita(x,y) < pi*3/8)
        ahead = [x,y] + cell_n{2,1};
        back = [x,y] +  cell_n{2,2};
%         ahead2 = ahead + cell_n{2,1};
%         back2 = back +  cell_n{2,2};
    elseif (sita(x,y) >= pi*3/8) & (sita(x,y) < pi*5/8)
        ahead = [x,y] + cell_n{3,1};
        back = [x,y] +  cell_n{3,2};
%         ahead2 = ahead + cell_n{3,1};
%         back2 = back +  cell_n{3,2};
    elseif (sita(x,y) >= pi*5/8) & (sita(x,y) < pi*7/8)
        ahead = [x,y] + cell_n{4,1};
        back = [x,y] +  cell_n{4,2};
%         ahead2 = ahead + cell_n{4,1};
%         back2 = back +  cell_n{4,2};
	elseif (sita(x,y) >= pi*7/8) & (sita(x,y) < pi*9/8)
        ahead = [x,y] + cell_n{5,1};
        back = [x,y] +  cell_n{5,2};
%         ahead2 = ahead + cell_n{5,1};
%         back2 = back +  cell_n{5,2};
	elseif (sita(x,y) >= pi*9/8) & (sita(x,y) < pi*11/8)
        ahead = [x,y] + cell_n{6,1};
        back = [x,y] +  cell_n{6,2};
%         ahead2 = ahead + cell_n{6,1};
%         back2 = back +  cell_n{6,2};        
	elseif (sita(x,y) >= pi*11/8) & (sita(x,y) < pi*13/8)
        ahead = [x,y] + cell_n{7,1};
        back = [x,y] +  cell_n{7,2};
%         ahead2 = ahead + cell_n{7,1};
%         back2 = back +  cell_n{7,2};
	elseif (sita(x,y) >= pi*13/8) & (sita(x,y) < pi*15/8)
        ahead = [x,y] + cell_n{8,1};
        back = [x,y] +  cell_n{8,2};
%         ahead2 = ahead + cell_n{8,1};
%         back2 = back +  cell_n{8,2};
	elseif (sita(x,y) >= pi*15/8) & (sita(x,y) <= pi*16/8)
        ahead = [x,y] + cell_n{1,1};
        back = [x,y] +  cell_n{1,2};
%         ahead2 = ahead + cell_n{1,1};
%         back2 = back +  cell_n{1,2};
    end
  
    
    
    
%     gcount(1) = mag_g(back2(1),back2(2));
    gcount(1) = mag_g(back(1),back(2));
    gcount(2) = mag_g(x,y);
    gcount(3) = mag_g(ahead(1),ahead(2));
%     gcount(5) = mag_g(ahead2(1),ahead2(2));
    
    %debug
%     if (x == 192 & y == 248) | (back(1)== 192 & back(2) == 248) | (ahead(1)== 192 & ahead(2) == 248)
%         disp('a')
%     end
    %end_debug
    
    max_index = find(gcount == max(gcount));
    
    if max(gcount) > threshold
        
        if size(max_index,2) ~= 1
            max_index = max_index(1);
        end


        if max_index == 1
            new_g(back(1),back(2)) = 1;
        elseif max_index == 2
            new_g(x,y) = 1;
        elseif max_index == 3
            new_g(ahead(1),ahead(2)) = 1;
        end

%         if max_index == 1
%             new_g(back2(1),back2(2)) = 1;
%         elseif max_index == 2
%             new_g(back(1),back(2)) = 1;
%         elseif max_index == 3
%             new_g(x,y) = 1;
%         elseif max_index == 4
%             new_g(ahead(1),ahead(2)) = 1;
%         elseif max_index == 5
%             new_g(ahead2(1),ahead2(2)) = 1;
%         end
        
        
    end
    
end
    