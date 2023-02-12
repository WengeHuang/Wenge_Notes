clc;
clear;
a=110:1:150;
X=a/180*pi;
f1=(1-cos(X)).^2./(sin(X)).^4;
plot(a,f1,'*-');
hold on 
f2=(1-cos(X)).^2.*(2+cos(X))./(sin(X)).^3;
plot(a,f2,'o-');
grid on
