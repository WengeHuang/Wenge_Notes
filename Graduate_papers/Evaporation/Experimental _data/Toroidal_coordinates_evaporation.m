%Toroidal coordinate
%Deegans_f(0,pi/2)
clc;
clear;
J=zeros(25,1);
I=zeros(25,1);
for i=1:1:25;
    I(i)=-0.2+0.2*i;
J(i)=Deegans_f(I(i),3/4*pi);
end
hold on
plot(I,J)