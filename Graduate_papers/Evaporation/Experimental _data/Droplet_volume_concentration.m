clc;
clear;
%inport the time [s], radius [mm] and real volume [uL]
%D=importdata ('Droplet_Volume.xlsx'); 
D=xlsread('Volume_concentration.xlsx',1);
Tw=70+273.15;               % water temperatureK   remember to change
Ta=20+273.15;      % ambient temperature
rho=1000; %water density kg/m^3
[r,c]=size(D);
t=zeros(r,1);
R=zeros(r,1);
V=zeros(r,1);
CA=zeros(r,1);
A=zeros(r,1);
i=1:1:r;
t(i)=D(i,1);
R(i)=D(i,3)/1000; %change the [mm] to [m]
V(i)=D(i,2)/1000000000; %change [uL] to [m^3]
CA(i)=D(i,4); %contact angle
plot(t,V,'*')
hold on
grid on
csw=9.7494*10^(-7)*(Tw-273.15)^3-5.8152*10^(-5)*(Tw-273.15)^2+0.0021*(Tw-273.15)-0.0022; %[kg/m^3]
csa=9.7494*10^(-7)*(Ta-273.15)^3-5.8152*10^(-5)*(Ta-273.15)^2+0.0021*(Ta-273.15)-0.0022; %[kg/m^3]
H=0.2; %humidity
Vp=zeros(r,1);
Df=26.1*10^(-6); %m^2/s
for j=1:1:r-1
Vp(1)=V(1);
%Tw=90+273.15; %
Vp(j+1)=Vp(j)-4*pi/(rho)*Df*R(j).*(t(j+1)-t(j))*(csw-H*csa)*(7.7033*10^(-6)*CA(j).^3-0.002518*CA(j).^2+0.2796*CA(j)-9.9249);
end
plot(t,Vp)










