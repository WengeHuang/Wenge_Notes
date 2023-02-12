%fit for temperature distribution
clc;
clear;
XX=xlsread('fitting_for_temperature_distribution.xlsx',3);
YY=xlsread('fitting_for_temperature_distribution.xlsx',4);
ZZ=xlsread('fitting_for_temperature_distribution.xlsx',5);
%x=D(:,1);
%y=D(:,2);
%x=[0,0.1262,0.2943,0.496,0.7801,0.8375,0.9704,1];
%y=[1,];
%plot(x,y,'*');
%hold on
%f1=polyfit(x,y,5);
%X=linspace(0,1);
%Y=ca*ones(1,100);
%Z=polyval(f1,X); 
%plot(X,Z)
X=meshgrid(0:0.01:1);
Y=transpose(meshgrid(40:1.2:160));
Z=ones(101,101);
for i=1:1:101
    for j=1:1:101
    Z(i,j)=Tdistribution(X(i,j),Y(i,j));
    end
end
surf(X,Y,Z)
view(2)
colorbar

