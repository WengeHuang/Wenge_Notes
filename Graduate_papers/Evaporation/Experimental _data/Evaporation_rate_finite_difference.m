%evaporation flux of droplet
clc;
clear;
D=xlsread('Evaporation_rate_test.xlsx',1);
T_s=90;           % substrate temperature to determain the latent heat and density
[r,c]=size(D);
T=zeros(r,1);                % Time of the evaporation
V=zeros(r,1);                % Volume of the evaporation uL need to *10^(-9)
R=zeros(r,1);                % Contact radius  [mm] need to *10^(-3)
H=zeros(r,1);                % Droplet height [mm] need to *10^(-3)
Q=zeros(r,1);                % Evaporation rate [W]
i=1:1:r;
T(i)=D(i,1);
V(i)=D(i,2)*10^(-9);         %m^3
R(i)=D(i,3)*10^(-3);         %m
H(i)=D(i,4)*10^(-3);         %m
Latent=h_fg(T_s);            %water latent heat J/kg
rho=rho_w(T_s);              %water density kg/m^3
%fitting of volume
p1=polyfit(T,V,5);  
n=100;
x=linspace(T(1),T(r),n);
y1=polyval(p1,x); 
plot(T,V,'*');
hold on
plot(x,y1,'-')
y3=polyval(p1,T); 
%VV=zeros(r,1); 
%for i=1:1:r
%    VV(i)=V_f(T(i),p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
%end
%plot(T,VV,'o');

dt=0.1;       
dVdt=zeros(r,1); 
for i=1:1:r
    a1=V_f(T(i)+2*dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    a2=V_f(T(i)+dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    a3=V_f(T(i)-dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    a4=V_f(T(i)-2*dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    
    dVdt(i)=-(-a1+8*a2-8*a3+a4)/(12*dt);
end
Q=dVdt*Latent*rho;

dVdt=zeros(n,1); 
for i=1:1:n
    a1=V_f(x(i)+2*dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    a2=V_f(x(i)+dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    a3=V_f(x(i)-dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    a4=V_f(x(i)-2*dt,p1(1),p1(2),p1(3),p1(4),p1(5),p1(6));
    
    dVdt(i)=-(-a1+8*a2-8*a3+a4)/(12*dt);
end
y2=dVdt*Latent*rho;
plot(x,y2,'-')


% Ctrl + r
% Ctrl + t




