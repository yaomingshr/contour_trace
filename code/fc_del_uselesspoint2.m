function new_g = fc_del_uselesspoint2(g)
%该函数用于final_corrcet中删除单独延伸的点 并且与edge_detection对应

edge_g = find(g == 1);
new_g = g;
for i = 1 : size(edge_g,1)
    [x,y] = ind2sub(size(g),edge_g(i));
    %debug
%     if x == 168 & y == 246
%         disp(i);
%     end
    %endebug
    cen_P = [x,y];
    [nei_num,nei_x,nei_y] = findNeighbor(cen_P,new_g);
    if nei_num == 0
        new_g(x,y) = 0;
    elseif nei_num == 1
        new_g(x,y) = 0;
        while 1
            nei_P = [nei_x,nei_y];
            [this_num,nei_x,nei_y] = findNeighbor(nei_P,new_g);
            if this_num == 0
                new_g(nei_x,nei_y) = 0;
                break;
            elseif this_num == 1
                new_g(nei_P(1),nei_P(2)) = 0;
            elseif this_num == 2
                break;
            end
        end
    end
end

