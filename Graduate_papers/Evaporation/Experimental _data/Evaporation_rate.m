%evaporation flux of droplet
clc;
clear;
D=xlsread('Evaporation_rate_test.xlsx',1);
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
Latent=2.26*10^6;            %water latent heat J/kg
rho=1000;                    %water density kg/m^3
%fitting of volume
p1=polyfit(T,V,10);  
n=30;
x=linspace(T(1),T(r),n);
y1=polyval(p1,x); 
subplot(1,2,1);
plot(T,V,'*');
hold on
subplot(1,2,1);
plot(x,y1,'-')
q=zeros(1,n-1);
X=zeros(1,n-1);
j=1:1:n-1;
q(j)=(y1(j)-y1(j+1))./(x(j+1)-x(j))*Latent*rho;       % [W]
X(j)=0.5*(x(j+1)+x(j));
subplot(1,2,2);
plot(X,q,'-');
%plot(x,q)
hold on
q1=zeros(1,r-1);
X1=zeros(1,r-1);
j=1:1:r-1;
q1(j)=(V(j)-V(j+1))./(T(j+1)-T(j))*Latent*rho;       % [W]
X1(j)=0.5*(T(j+1)+T(j));
%plot(X1,q1,'*');
%fiting of height since heigh is better than contact radius to fit
p2=polyfit(X,q,4);  
y2=polyval(p2,x);

hold on
%plot(x,y2)
%%% contact radius function
i=1:1:r;
Q(i)=p2(1)*T(i).^4+p2(2)*T(i).^3+p2(3)*T(i).^2+p2(4)*T(i)+p2(5);
subplot(1,2,2);
plot(T,Q,'*')



