function re_para = linear_equation(a1,a2)

k = (a1(2)-a2(2))/(a1(1)-a2(1));
b = a1(2) - k*a1(1);

if k == -Inf | k == Inf
    k = Inf;
    b = 'n';
end

re_para(1) = k;
re_para(2) = b;

end
