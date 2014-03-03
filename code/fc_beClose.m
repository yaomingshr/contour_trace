function new_g = fc_beClos(grad_img,g)
%�����׶Σ�ɾ�����õ����ж��ε���contour trace ��ʹ�������պ�
edge_g = find(g == 1);
threshold = 30;
for i = 1 : size(edge_g,1)
	[x,y] = ind2sub(size(g),edge_g(i));
    P = [x,y];
    [num,bx,by] = findNeighbor(P,g);
    if num == 1      %ĳ���������յ�
        bP = [bx,by];
        while 1
        N = sp_contrace(P,bP,grad_img,g);
        if grad_img(N(1),N(2)) > threshold
            g(N(1),N(2)) = 1;
            [Nnum,~,~] = findNeighbor(N,g);
            if Nnum ~= 1               %�Ѿ�����һ�������ı�Ե�������
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