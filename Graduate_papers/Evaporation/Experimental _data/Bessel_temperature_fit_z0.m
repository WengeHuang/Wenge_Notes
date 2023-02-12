clc;
clear;
D=xlsread('Bessel_temperature_matlab.xlsx',1);
% this one is the value of a/b from 0.1 to 0.6. at every certain a/b we
% have 8 different of r/a from 0 to 1. 
% 1 is z=0
[r,c]=size(D);              %dimension of D
R=zeros(r-1,1);
T=zeros(r-1,1);
i=1:1:r-1;
T(i)=D(i+1,1);              % T is the 8 value of r/a from 0 to 1
for k=2:1:c                 % here k start from 2 
j=k;
R(i)=D(i+1,j);      
p=polyfit(T,R,3);
x=linspace(T(1),T(r-1));
y=polyval(p,x);
%figure
plot(T,R,'*')
hold on
plot(x,y)
end
% we get the summation of Bessel function with different a/b, and for
% certain a/b with r/a from 0 to 1
