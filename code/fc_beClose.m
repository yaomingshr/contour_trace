function new_g = fc_beClos(grad_img,g)
%最后处理阶段，删除无用点后进行二次单点contour trace 来使得轮廓闭合
edge_g = find(g == 1);
threshold = 30;
for i = 1 : size(edge_g,1)
	[x,y] = ind2sub(size(g),edge_g(i));
    P = [x,y];
    [num,bx,by] = findNeighbor(P,g);
    if num == 1      %某段轮廓的终点
        bP = [bx,by];
        while 1
        N = sp_contrace(P,bP,grad_img,g);
        if grad_img(N(1),N(2)) > threshold
            g(N(1),N(2)) = 1;
            [Nnum,~,~] = findNeighbor(N,g);
            if Nnum ~= 1               %已经和另一段轮廓的边缘点接上了
                break;
            end
            bP = P;
            P = N;
        else
            break;
        end
        end
    end
end

new_g = g;