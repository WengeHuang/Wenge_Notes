clc;
clear;
D=xlsread('Bessel_temperature_matlab.xlsx',7);
% 7 is the data for z=0.1b height
[r,c]=size(D);              %dimension of D
R=zeros(1,c);
T=zeros(r-1,1);
RR=zeros(r-1,1);
i=1:1:c;
R(i)=D(1,i);
for k=1:1:c
%j=30;
j=k;
i=1:1:r-1;
T(i)=D(i+1,j);      
RR(1)=0;
RR(r-1)=1;
RR(2)=R(j);
RR(3)=0.5;
p=polyfit(RR,T,2);
x=linspace(RR(1),RR(r-1));
y=polyval(p,x);
%figure
plot(RR,T,'*')
hold on
plot(x,y)
%hold off
end







