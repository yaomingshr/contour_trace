function c_g = final_correct(grad_img,g)
%del_g = del_uselesspoint(g);
close_g = fc_beClose(grad_img,g);
c_g = fc_del_uselesspoint2(close_g);