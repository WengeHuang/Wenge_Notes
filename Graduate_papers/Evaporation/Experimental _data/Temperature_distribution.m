%temperature distribution
clc;
clear;
Tb=60+273.15;    %droplet base temperature
ca=150/180*pi;   %contact angle of the droplet
D=26.1*10^(-6);  %m^2/s  diffusion coefficient
H=0.35;          %relative humidity
n=100;
h=zeros(n,1);    %matrix of droplet height from 0 to 1 
dS=zeros(n,1);   %matrix of surface area for evaporation flux
r=zeros(n,1);    %matrix of droplet radius
T=zeros(n,1);    %matrix for surface temperature
T(1)=Tb-273.16;
R=zeros(n,1);    %Thermal resistance of each layer
J=zeros(n,1);    %evaporation flux of each layer
f=zeros(n,1);    %heat flux of each layer
for i=1:1:n
    h(i)=0+0.01*i;  %nondimensional height of droplet
    dh=0.01;
    r(i)=r_h(h(i),1/tan(ca/2),ca);  % radius of the droplet with respect to h
    dS(i)=2*pi*(1/(tan(ca/2)*sin(ca)))*dh;% here 0.01 is dh 
    %等分高度对应等分面积
    R(i)=dh/(k_w(T(i))*pi*r(i)^2);    % K/W
    rc=1/tan(ca/2);
    J(i)=D*(c_w(T(i))-H*c_w(20))/rc*Evap_flux(h,ca)*dS(i)*h_fg(T(i));  %  W
    f(i+1)=f(i)-J(i);                 % rest heat flux  W
    T(i+1)=T(i)-R(i)*f(i+1);
    
    
end
