function sm_g = fc_beSmooth(g)
edge_g = find(g == 1);
sm_g = g;
for i = 1 : size(edge_g,1)
    [x,y] = ind2sub(size(g),edge_g(i));
    cen_P = [x,y];
    [nei_num,~,~] = findNeighbor(cen_P,g);
    if nei_num == 0 | nei_num == 1
        sm_g(x,y) = 0;
    end
end