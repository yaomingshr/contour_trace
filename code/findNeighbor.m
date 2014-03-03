function [num,x,y] = findNeighbor(P,g)
%ֻ��һ���ھ�ʱ�������ھ�λ�ã���0����2�������ϣ��ھ�ʱ��x��y������
cell_pos={[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1],[1,0],[1,1]};
num = 0;
x = 0;
y = 0;
for i = 1 : 8
    rel_pos = cell_pos{i};
    abs_pos = rel_pos + P;
    if g(abs_pos(1),abs_pos(2)) == 1
        num = num + 1;
        x = abs_pos(1);
        y = abs_pos(2);
    end
    
    if num == 2
        x = 0;
        y = 0;
        return;
    end
end