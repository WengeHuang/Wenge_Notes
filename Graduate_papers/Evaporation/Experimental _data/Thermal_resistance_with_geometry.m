clc;
clear;
%for k=2:1:10
D=xlsread('Bessel_temperature_matlab.xlsx',1);
% 1 is with r/a from 0 to 1
% 8 we add r=b point
[r,c]=size(D);              %dimension of D
P=zeros(1,c-1);
dp=zeros(1,c-1);
R=zeros(r-1,1);
T=zeros(r-1,1);
Rs=zeros(c-1,5);
R1=zeros(c-1,1);
Ra=zeros(c-1,1);
for j=2:1:c
%j=5
i=1:1:r-1;
T(i)=D(i+1,1);
i=1:1:c-1;
P(i)=D(1,i+1);          %P is the ratio of a and b a/b but need to become d/p
%j=k;
%for j=2:1:101
%j=100;
i=1:1:r-1;
R(i)=D(i+1,j); 
%%%%%  change to 0-b range
%T=T*P(j-1);
%T(r-2)=0.8;
%T(r-1)=1;
%%%%%
p=polyfit(T,R,3);
x=linspace(T(1),T(r-1));
y=polyval(p,x);                  % y is the value of the summation of bessel function with different r from 0 to a
%figure
%plot(T,R,'*')
%hold on
%plot(x,y)
%hold off
kSi=100;     %conductive heat transfer coefficient  W/(mK)
%kw=0.667;     %conductive heat transfer coefficient  W/(mK)
k=kSi;



%f=9.9472*10^5;              %here we keep the f constant
%b=1;    %radius of periodicity [m]
rr=P(j-1);     %ratio of a b, r=a/b 
a=10*10^(-6);     %radius of pillar [m]
b=a/rr;
%b=22.811*10^(-6); %here we keep b constant and change a to change the radio
%a=b*rr;
%f=0.2/640/(pi*a*a);        %heat flux [W/m^2]
f=10^6;
bb=b*sqrt(pi);
z=0;     %height [m]
L1=1000*10^(-6);     %thickness of substrate [m]
S1=y;     %summmation of the bessel functions
Te1=f/k*(L1-z)*(a^2/b^2)+f/k*2*a*S1;
%plot(x,Te1)
hold on
%end

kw=0.667;     %conductive heat transfer coefficient  W/(mK)   
S2=y;     %summmation of the bessel functions
L2=2/3.817*b;     %thickness of water layer [m] minimum
%Te2=f/kw*(L2)*(a^2/b^2)+f/kw*2*a*S2;%-13.7;   %here we -13.7 is to let the temperature the same as L
Te2=f/kw*2*a*S2*(b^2/(b^2-a^2));
%plot(x*rr,Te2)
plot(x,Te2)
hold on
hs=40*10^(-6);    %height of the micropillar [m]
Rp=hs/(kSi*pi*a*a);     % thermal resistance of the micropillar
RSi=L1/(kSi*pi*b*b);    % thermal resistance of the substrate
Rwl=L2/(kw*pi*b*b);     % thermal resistance of the water layer
DT=f*pi*a*a*Rp;

Ta=0;
for i=1:1:99
    Ta=Ta+(Te2(i)*((x(i+1))^2-(x(i))^2))/0.99^2;
end
Tp1=Te1+DT+Ta;
Rsmax=Te2(1)/f/(pi*a*a)-Rwl ;      %maximum spreading resistance
Rsave=Ta/f/(pi*a*a)-Rwl;           % average spreading resistance
%R1(j-1)=Te1(j-1)/f/(pi*a*a)-RSi;         
R1(j-1)=(0.5*1000*10^(-6))^2/b^2;
Rs(j-1,1)=Rsave;        %K/W 
Rs(j-1,2)=Rwl;
Rs(j-1,3)=RSi;
Rs(j-1,4)=Rp;
Rs(j-1,5)=Rsave+Rwl+RSi+Rp;
end