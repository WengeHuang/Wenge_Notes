%Evaporation flux
clc;
clear;
ca=120/180*pi;   %contact angle
A=-0.29*ca*ca+1.94*ca-1.34;
k=1+31.86*exp(-3.54*ca);
b=0.61*ca*ca-2.12*ca+6.16;
L=3*(0.5-ca/pi);
h=0:0.01:1;
J1=A*(k-exp(-b*h)).^(-L);
plot(h,J1);
hold on
c=ca:-0.01:0;
H=(cos(c)-cos(ca))/(1-cos(ca));
J2=A*(k-exp(-b*H)).^(-L);
S=0;
ra=zeros(1,length(c));
for i=1:1:length(c)
S=S+0.01*sin(c(i))*A*(k-exp(-b*H(i)))^(-L);
end

for n=1:1:length(c);
    SS=0;
 for j=1:1:n
 SS=SS+0.01*sin(c(j))*A*(k-exp(-b*H(j)))^(-L);
 end
 ra(n)=SS/S;
end
%plot(H,ra);


%kk=0:0.01:0.9;
%plot(kk,kk./(1-kk))



