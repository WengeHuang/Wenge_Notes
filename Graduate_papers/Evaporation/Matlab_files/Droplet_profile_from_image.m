clear;
clc;
%读取原图
im1 = imread('sample0temp80_1.png'); 
im2 = imread('sample0temp80_10.png'); 
im3 = imread('sample0temp80_30.png'); 
im4 = imread('sample0temp80_50.png'); 
im5 = imread('sample0temp80_60.png'); 
im6 = imread('sample0temp80_70.png'); 
im7 = imread('sample0temp80_80.png'); 
im8 = imread('sample0temp80_100.png'); 
im9 = imread('sample0temp80_110.png'); 
%im10 = imread('dropletp44.png'); 
%im11 = imread('dropletp45.png'); 
%im12 = imread('dropletp46.png'); 
%im13 = imread('dropletp47.png'); 
%im14 = imread('dropletp48.png'); 
%im15 = imread('dropletp49.png'); 
%imshow(im1);
%imshow(im2);
%title('原图');                       
 
% 转二值图像imbinarize
bw1 = im2bw(im1);
bw2 = im2bw(im2);
bw3 = im2bw(im3);
bw4 = im2bw(im4);
bw5 = im2bw(im5);
bw6 = im2bw(im6);
bw7 = im2bw(im7);
bw8 = im2bw(im8);
bw9 = im2bw(im9);
%bw10 = im2bw(im10);
%bw11 = im2bw(im11);
%bw12 = im2bw(im12);
%bw13 = im2bw(im13);
%bw14 = im2bw(im14);
%bw15 = im2bw(im15);
% %轮廓提取   
contour1 = bwperim(bw1);
contour2 = bwperim(bw2);
contour3 = bwperim(bw3);
contour4 = bwperim(bw4);
contour5 = bwperim(bw5);
contour6 = bwperim(bw6);
contour7 = bwperim(bw7);
contour8 = bwperim(bw8);
contour9 = bwperim(bw9);
%contour10 = bwperim(bw10);
%contour11 = bwperim(bw11);
%contour12 = bwperim(bw12);
%contour13 = bwperim(bw13);
%contour14 = bwperim(bw14);
%contour15 = bwperim(bw15);
%figure
%imshow(contour1);
%title('轮廓')
%     https://www.mathworks.com/help/matlab/ref/find.html
%[row, col]=find (_) returns the row and column subscripts of each nonzero
%element
[i1,j1]=find(contour1);
[i2,j2]=find(contour2);
[i3,j3]=find(contour3);
[i4,j4]=find(contour4);
[i5,j5]=find(contour5);
[i6,j6]=find(contour6);
[i7,j7]=find(contour7);
[i8,j8]=find(contour8);
[i9,j9]=find(contour9);
%[i10,j10]=find(contour4);
%[i11,j11]=find(contour5);
%[i12,j12]=find(contour6);
%[i13,j13]=find(contour7);
%[i14,j14]=find(contour8);
%[i15,j15]=find(contour9);
plot (j1,i1,'.'); hold on;
plot (j2,i2,'.'); hold on;
plot (j3,i3,'.'); hold on;
plot (j4,i4,'.'); hold on;
plot (j5,i5,'.'); hold on;
plot (j6,i6,'.'); hold on;
plot (j7,i7,'.'); hold on;
plot (j8,i8,'.'); hold on;
plot (j9,i9,'.'); hold off;
%plot (j10,i10,'.'); hold on;
%plot (j11,i11,'.'); hold on;
%plot (j12,i12,'.'); hold on;
%plot (j13,i13,'.'); hold on;
%plot (j14,i14,'.'); hold on;
%plot (j15,i15,'.'); hold off;
set(gca, 'YDir','reverse')
