r = 0.72;
DCM = dicomread('D:\百度云\毕业设计\dicom\IM144.dcm');
[gauSita,q,sigma] = myGaussian(DCM);

res_grac = grad_magnitudc(DCM);
res_grad = grad_magnitude(DCM);
figure, imshow(res_grad,[ ])
seed1 = [215,238];
res_1 = contour_trace(res_grad,seed1);
seed2 = [215,283];
res_2 = contour_trace(res_grac,seed2);
seed3 = [289,101];
res_3 = contour_trace(res_grac,seed3);
seed4 = [300,184];
res_4 = contour_trace(res_grac,seed4);
seed5 = [311,324];
res_5 = contour_trace(res_grac,seed5);
seed6 = [267,379];
res_6 = contour_trace(res_grac,seed6);
res_25 = res_2 + res_3 + res_4 + res_5 + res_6;
res_c = res_1 + res_25;
figure, imshow(res_c,[ ])
conSita = contour_sita(res_25 + res_1);
% conSita = contour_sita(res_1);
finalSita = r * q .* gauSita + (1 - r * q) .* conSita;

d_consita = conSita * 180 / pi;
d_gausita = gauSita * 180 / pi;
d_fsita = finalSita * 180 / pi;


% res_final = edge_detection(DCM,res_1,finalSita,sigma);
res_f1 = edge_detection2(res_grad,res_1,finalSita);
res_c1 = final_correct(res_grad,res_f1);

res_f25 = edge_detection2(res_grac,res_25,finalSita);
res_final = res_c1 + res_f25;
combineShow(DCM,res_final)
