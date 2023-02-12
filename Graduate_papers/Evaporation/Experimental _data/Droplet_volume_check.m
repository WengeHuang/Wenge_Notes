clc;
clear;
%import the time [s], radius [mm] and real volume [uL]
%D=importdata ('Droplet_Volume.xlsx'); 

D=xlsread('Volume_Time_radius_last.xlsx',1);
TH=100+273.15;               % Hot plate temperatureK   remember to change
Tw=88+273.15; %
Fi=0.3142;  %0.3142-20-40 %0.3642-20-50 %0.3975-20-60 0.3639-20-50L %0.3642-16-40  
b=40/1000000; %width of unit cell m
w=20/1000000; %diameter of micropillar m remember to divided by 2 
hs=40/1000000; %height of micropillar m


[r,c]=size(D);               %D1 is time begins not from 0; D2 is volume
%D3 is radius without transforming into mm D4 is time starts from 0, D 5 is
%contact radius (not contact diameter) in mm
t=zeros(r,1);
R=zeros(r,1);
V=zeros(r,1);
i=1:1:r;
t(i)=D(i,4);
R(i)=D(i,5)/1000; %change the [mm] to [m]
V(i)=D(i,2)/1000000000; %change [uL] to [m^3]
plot(t,V,'*'); %plot out the true volume with time
hold on;
rho=1000; %water density kg/m^3
L=2.26*10^6; %water latent heat J/kg

rho*(V(1)-V(10))/(t(10)-t(1))*L
pi*R(1)^2/b^2

hSi=1/1000; %thickness of substrate m
kSi=130; %conductivity of Si W/(mK)
kw=0.679;%conductivity of water W/(mK)
R2=hs/(kSi*pi*w^2/4)   %thermal resistance of the micropillar
R3=hSi/(kSi*b^2)       %thermal resistance of the substrate unit
kv=0.032; %conductivity of vapor W/ mK


%spreading coefficient


Rs=Fi/(kw*w/2*sqrt(3.14))         %remember this should be w/2 because we need to use the radius
Rc=Fi/(kSi*w/2*sqrt(3.14))        
C1=b^2/(pi)*(R2+R3+Rs+Rc);
Vp=zeros(r,1);
for j=1:1:r-1
Vp(1)=V(1);
%Tw=90+273.15; %
Vp(j+1)=Vp(j)-(TH-Tw)/(rho*L*C1)*R(j+1).*R(j+1).*(t(j+1)-t(j));
end
plot(t,Vp)
grid on
%plotyy(t,Vp,t,R)
xlabel('time/s');
ylabel('Volume/uL');

%R2+R3+Rs+Rc
rho*(V(1)-V(10))/(t(10)-t(1))*L
pi*R(1)^2/b^2




