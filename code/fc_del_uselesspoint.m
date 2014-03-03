function new_g = fc_del_uselesspoint(g)
%�ú�������final_corrcet��ɾ������1-2���� ������edge_detection2��Ӧ
edge_g = find(g == 1);
new_g = g;
for i = 1 : size(edge_g,1)
    [x,y] = ind2sub(size(g),edge_g(i));
    cen_P = [x,y];
    [nei_num,nei_x,nei_y] = findNeighbor(cen_P,g);
    if nei_num == 0
        new_g(x,y) = 0;
    elseif nei_num == 1
        nei_P = [nei_x,nei_y];
        [this_num,~,~] = findNeighbor(nei_P,g);
        if this_num == 1
            new_g(x,y) = 0;
            new_g(nei_x,nei_y) = 0;
        end
    end
end