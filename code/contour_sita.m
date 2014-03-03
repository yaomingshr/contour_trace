function c_Sita = contour_sita(g_contour)
% first_p = true;
% for x = 1 : size(contour,1)
%     for y = 1 : size(contour,2)
%         if contour(x,y) == 1
%             if first_p
%                 curve_x = y;
%                 curve_y = x;
%                 first_p = false;
%             else
%                 curve_x(end + 1) = y;
%                 curve_y(end + 1) = x;
%             end
%         end
%     end
% end
% curve = polyfit(curve_x,curve_y,5);
% cz = polyval(curve,curve_x);
% figure, plot(curve_x,curve_y,'r*',curve_x,cz,'b')
% c_Sita = 0;   %test
% % syms cy cx;
c_Sita = double(g_contour);
edge_p = find(g_contour == 1);
for i = 1 : size(edge_p)
    [c1,c2] = ind2sub(size(g_contour),edge_p(i));
    C = [c1 c2];
    %degub
%     if c1 == 210 & c2 == 238
%         disp('aa');
%     end
    %end_debug
    gotP = false;
    c_region = g_contour((c1-1):(c1+1),(c2-1):(c2+1));
    for cr_i = 1 : 3
        for cr_j = 1 : 3
            if (c_region(cr_i,cr_j) == 1) & ((cr_i ~= 2) | (cr_j ~= 2))
                if gotP
                    N = [c1+cr_i-2 c2+cr_j-2];
                else
                    P = [c1+cr_i-2 c2+cr_j-2];
                    gotP = true;
                end
            end
        end
    end
    
    line1_para = linear_equation(C,P);
    line2_para = linear_equation(C,N);
        
    if line1_para(1) == line2_para(1)
        %3点一线，直接垂直这条线就是法线
        nK = -(1 / line1_para(1));

    else
        %3点不一线，则中垂线必定有交点
        M1 = (C + P) / 2;
        M2 = (C + N) / 2;
        mv_k1 = - (1 / line1_para(1));
        mv_k2 = - (1 / line2_para(1));
        
        if mv_k1 == Inf | mv_k1 == -Inf
            mv_k1 = Inf;
            mv_b1 = 'n';
        else
            mv_b1 = M1(2) - mv_k1 * M1(1);
        end
        
        if mv_k2 == Inf | mv_k2 == -Inf
            mv_k2 = Inf;
            mv_b2 = 'n';
        else
            mv_b2 = M2(2) - mv_k2 * M2(1);
        end
        

        if mv_k1 == Inf
            OC(1) = (C(1) + P(1)) / 2;
            OC(2) = mv_k2 * OC(1) + mv_b2;
        elseif mv_k2 == Inf
            OC(1) = (C(1) + N(1)) / 2;
            OC(2) = mv_k1 * OC(1) + mv_b1;
        else
            OC(1) = (mv_b1 - mv_b2) / (mv_k2 - mv_k1);
            OC(2) = mv_k1 * OC(1) + mv_b1;
        end
        
        nK = (OC(2) - C(2)) / (OC(1) - C(1));
        
        %OC 和 C的连线为法线
    end
	if nK == Inf | nK == -Inf
        nK = Inf;
        nB = 'n';
    else
        nB = C(2) - (nK * C(1));
	end
    n_para(1) = nK;
    n_para(2) = nB;
    c_Sita(c1,c2) = cs_getconSita(C,g_contour,n_para);
end

    


