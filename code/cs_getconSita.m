function sita = cs_getconSita(C,g_contour,n_para)
% edge_p = find(g_contour == 1);
% node = [1000 1000];
% for i = 1 : size(edge_p,1)
%     [x,y] = ind2sub(size(g_contour),edge_p(i));
%     if (x ~= C(1) | y ~= C(2)) & (y == floor(n_para(1) * x + n_para(2)) | y == ceil(n_para(1) * x + n_para(2)))     %找到轮廓和直线的非C交点
%         node = [x y];
%         break;          
%         %此种方法暂时没有凹曲面
%     elseif (n_para(1) == Inf) & (x == C(1)) & (y ~= C(2))              %解决法线为垂直x轴的特殊情况
%         node = [x y];
%         break;
%     end
% end
% 
% %degug
% if node == [1000 1000]
%     disp('test')
% end
% for i = 1 : size(edge_p,1)
%     [x,y] = ind2sub(size(g_contour),edge_p(i));
%     if (x ~= C(1) | y ~= C(2)) & (y == floor(n_para(1) * x + n_para(2)) | y == ceil(n_para(1) * x + n_para(2)))     %找到轮廓和直线的非C交点
%         node = [x y];
%         break;          
%         %此种方法暂时没有凹曲面
%     elseif (n_para(1) == Inf) & (x == C(1)) & (y ~= C(2))              %解决法线为垂直x轴的特殊情况
%         node = [x y];
%         break;
%     end
% end
% 
% n = [C(1)-node(1) C(2)-node(2)];     %由node指向C的向量即为法线
% nx = [1 0];
% tempsita = acos((nx(1)*n(1) + nx(2)*n(2)) / sqrt((n(1)^2) + (n(2)^2)));
% if n(2) < 0
%     sita = 2 * pi - tempsita;
% else
%     sita = tempsita;
% end


%方法2，利用点和切线的分布位置关系
edge_p = find(g_contour == 1);
smaller_count = 0;
greater_count = 0;
%找到切线
if n_para(1) == 0               % x = C(1) 
    tan_para(1) = Inf;
    tan_para(2) = 'n';
    for i = 1 : size(edge_p,1)
        [x,y] = ind2sub(size(g_contour),edge_p(i));
        if x < C(1)
            smaller_count = smaller_count + 1;
        else
            greater_count = greater_count + 1;
        end
    end
    
    if smaller_count > greater_count
        sita = 0;
    else
        sita = pi;
    end
    
    return;
        
elseif n_para(1) == Inf         % y = C(2)
    tan_para(1) = 0;
    tan_para(2) = C(2);
    
else 
    tan_para(1) = - (1 / n_para(1));
    tan_para(2) = C(2) - tan_para(1) * C(1);
end

for i = 1 : size(edge_p,1)
	[x,y] = ind2sub(size(g_contour),edge_p(i));
    if y > tan_para(1) * x + tan_para(2);
        greater_count = greater_count + 1;
    else
        smaller_count = smaller_count + 1;
    end
end

if smaller_count > greater_count
	if tan_para(1) == 0
        sita = pi / 2;
        return;
    elseif tan_para(1) > 0
        NC(1) = C(1) - 1;
        NC(2) = n_para(1) * NC(1) + n_para(2);
        n_vec = NC - C;
    elseif tan_para(1) < 0
        NC(1) = C(1) + 1;
        NC(2) = n_para(1) * NC(1) + n_para(2);
        n_vec = NC - C;
    end
else
	if tan_para(1) == 0
        sita = pi * 3 / 2;
        return;
    elseif tan_para(1) > 0
        NC(1) = C(1) + 1;
        NC(2) = n_para(1) * NC(1) + n_para(2);
        n_vec = NC - C;
    elseif tan_para(1) < 0
        NC(1) = C(1) - 1;
        NC(2) = n_para(1) * NC(1) + n_para(2);
        n_vec = NC - C;
    end
end

nx = [1 0];
tempsita = acos((nx(1)*n_vec(1) + nx(2)*n_vec(2)) / sqrt((n_vec(1)^2) + (n_vec(2)^2)));
if n_vec(2) < 0
    sita = 2 * pi - tempsita;
else
    sita = tempsita;
end




