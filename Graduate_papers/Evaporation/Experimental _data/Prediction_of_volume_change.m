clc;
clear;
%import the time [s], radius [mm] and real volume [uL]
%D=importdata ('Droplet_Volume.xlsx'); 

D=xlsread('Volume_Time_radius_reload.xlsx',1);
TH=100+273.15;               % Hot plate temperatureK   remember to change
Tw=91.5+273.15; %
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
%plot(t,V,'*'); %plot out the true volume with time
%plot(t,R,'*'); %plot out the true volume with time
hold on;
rho=1000; %water density kg/m^3
L=2.26*10^6; %water latent heat J/kg

hSi=1/1000; %thickness of substrate m
kSi=130; %conductivity of Si W/(mK)
kw=0.679;%conductivity of water W/(mK)
%kw=0.59;%conductivity of water W/(mK)
%0.59 is from Marangoni convection in droplets on suoerhydrophobic
%surfacesJFM
R2=hs/(kSi*pi*w^2/4)   %thermal resistance of the micropillar
R3=hSi/(kSi*b^2)       %thermal resistance of the substrate unit
kv=0.032; %conductivity of vapor W/ mK

%spreading coefficient
Rs=Fi/(kw*w/2*sqrt(3.14))         %remember this should be w/2 because we need to use the radius
Rc=Fi/(kSi*w/2*sqrt(3.14))        
C1=b^2/(pi)*(R2+R3+Rs+Rc);

%Vp=zeros(r,1);
%for j=1:1:r-1
%Vp(1)=V(1);
%Vp(j+1)=Vp(j)-(TH-Tw)/(rho*L*C1)*R(j+1).*R(j+1).*(t(j+1)-t(j));
%end
%plot(t,Vp)
%grid on
%xlabel('time/s');
%ylabel('Volume/uL');

%Vp=V(1)-(TH-Tw)/(rho*L*C1)*R(1)*R(1)*t;
%plot(t,Vp)

CA=117/180*pi;
F=sin(CA)^3/((1-cos(CA))^2*(2+cos(CA)));
V1=pi*(R(1))^3/3/F;
dt=(V(1)-V1)/((TH-Tw)/(rho*L*C1)*(R(1)-0.02/1000)^2);
tr=0;
for i=1:1:r-1
    if t(i)<=dt&& t(i+1)>=dt
        tr=i;
    end
end
Rp=zeros(r,1);
for i=1:1:tr
    Rp(i)=R(1);
end
for i=tr:1:r
    Rp(i)=R(1)-0.02/1000-(TH-Tw)/(rho*L*C1)/pi*F*(t(i)-floor(dt)+1);
end
%subplot(1,2,1);
plot(t,R,'*',t,Rp); %plot out the true volume with time

Vp=zeros(r,1);
for j=1:1:r-1
Vp(1)=V(1);
Vp(j+1)=Vp(j)-(TH-Tw)/(rho*L*C1)*Rp(j+1).*Rp(j+1).*(t(j+1)-t(j));
end
%subplot(1,2,2);
%plot(t,V,'*',t,Vp); %plot out the true volume with time
grid on

%ratio=(V(1)-pi/3*R(1)^3*F)*F/(pi*R(1)^3)



