function combineShow(bs_img,g)
edge_g = find(g == 1);
boundary_val = 2000;
for i = 1 : size(edge_g,1)
	[x,y] = ind2sub(size(g),edge_g(i));
    bs_img(x,y) = bs_img(x,y) + boundary_val;
end
figure, imshow(bs_img,[])