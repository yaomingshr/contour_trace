function g = contour_trace(grad_img,seed)
    grad_img = double(grad_img);
    cell_cp={[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1],[1,0],[1,1]};   %8��������λ��
    cell_n={[-1,1],[1,1],[0,1],[-1,0],[1,0];
        [-1,0],[0,1],[-1,1],[-1,-1],[1,1];
        [-1,-1],[-1,1],[-1,0],[0,-1],[0,1];
        [0,-1],[-1,0],[-1,-1],[-1,1],[1,-1];
        [1,-1],[-1,-1],[0,-1],[-1,0],[1,0];
        [1,0],[0,-1],[1,-1],[1,1],[-1,-1];
        [1,1],[1,-1],[1,0],[0,-1],[0,1];
        [0,1],[1,0],[1,1],[1,-1],[-1,1]};
%     cell_n={[-1,1],[1,1],[0,1];
%             [-1,0],[0,1],[-1,1];
%             [-1,-1],[-1,1],[-1,0];
%             [0,-1],[-1,0],[-1,-1];
%             [1,-1],[-1,-1],[0,-1];
%             [1,0],[0,-1],[1,-1];
%             [1,1],[1,-1],[1,0];
%             [0,1],[1,0],[1,1]};
    grad_img=padarray(grad_img,[1,1],0,'both');
    boundary_val = -1000;
    
    %seed = seed + 1;
    rv = seed(1);
    cv = seed(2);
    
    if rv == 215 & cv == 238
            cell_n={[-1,1],[1,1],[0,1];
            [-1,0],[0,1],[-1,1];
            [-1,-1],[-1,1],[-1,0];
            [0,-1],[-1,0],[-1,-1];
            [1,-1],[-1,-1],[0,-1];
            [1,0],[0,-1],[1,-1];
            [1,1],[1,-1],[1,0];
            [0,1],[1,0],[1,1]};
    end
    

    S = [rv(1),cv(1)];
    P = S;
    
% 	seed(1) = seed(1) + 1;
%   seed(2) = seed(2) + 1;
    
    %������ֵ
    T = 30;
    grad_img(S(1),S(2)) = boundary_val;          %��ֹ���µ��������ٴα���������
    
    %����ʼ���3*3�������ҳ����ֵ����Ϊ�ڶ�����Ե��
    g = grad_img(S(1)-1:S(1)+1,S(2)-1:S(2)+1);
    max_val = max(g(:));
    [rv,cv] = find(g==max_val);
    C = P + [rv(1) - 2,cv(1) - 2];             %�������е�λ��ת����ʵ�ʾ���λ��
    %done = f(C(1),C(2)) < T;
    done = false;
    %���ڱ�֤��if(maxval<f(N2(1),N2(2)))�������ʼ��
    grad_img(S(1),S(2)) = -boundary_val;
    while ~done
        grad_img(C(1),C(2)) = boundary_val;
        c_p = C - P;
        for dir = 1:length(cell_cp)
            if cell_cp{dir} == c_p
                break;
            end
        end
        %�ں�ѡ����ѡ���ݶ�ֵ�������Ϊ��һ����Ե��
        max_val = boundary_val;
        for i = 1:size(cell_n,2)
            tempN = C + cell_n{dir,i};
            if(max_val < grad_img(tempN(1),tempN(2)))
                max_val = grad_img(tempN(1),tempN(2));
                N = tempN;
            end
        end
        %if(f(N(1),N(2))<T)|(N == S)
        if (IsNeighbor(seed ,N) == true) %|(grad_img(N(1),N(2))<T)
            done = true;
            %break;
        end
        %��ǰһ��Ե��P����Ϊ��ǰ��C�������ҳ��ı�Ե��N����Ϊ��ǰ��
        P = C;
        C = N;
        %debug
%         if C == [213,238]
%             disp('a')
%         end
    end
   
    grad_img(C(1),C(2)) = boundary_val;
    bi = find(grad_img==boundary_val);
    grad_img(:) = 0;
    grad_img(bi) = 1;
    grad_img(S(1),S(2)) = 1;
    grad_img = grad_img(2:end-1,2:end-1);
    g = grad_img;