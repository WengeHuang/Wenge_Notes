clc;
clear;
%import the time [s], radius [mm] and real volume [uL]
%D=importdata ('Droplet_Volume.xlsx'); 

D=xlsread('Volume_Time_radius_reload.xlsx',1);
TH=100+273.15;               % Hot plate temperatureK   remember to change
Tw=91    +273.15; %
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

rho*(V(1)-V(4))/(t(4)-t(1))*L
pi*R(1)^2/b^2

hSi=1/1000; %thickness of substrate m
kSi=100; %conductivity of Si W/(mK)
%kw=0.679;%conductivity of water W/(mK)
kw=0.677;%conductivity of water W/(mK)
R2=hs/(kSi*pi*w^2/4);   %thermal resistance of the micropillar
%R3=hSi/(kSi*b^2)       %thermal resistance of the substrate unit
kv=0.032; %conductivity of vapor W/ mK


%spreading coefficient


%Rs=Fi/(kw*w/2*sqrt(3.14))         %remember this should be w/2 because we need to use the radius
%Rc=Fi/(kSi*w/2*sqrt(3.14))        
%C1=b^2/(pi)*(R2+R3+Rs+Rc);
% x=0.2592 for 20-40 0.306 for 20-50, 0.338 for 20-60
x=0.2592;          %infinite summation of the Bessel function, related to a/b
a=w/2;
bb=sqrt(b*b/pi);                          % radius of the equivalent periodicity
th=1000*10^(-6);                          % thickness of the substrate [m]
Rs=th/kw*(a^2/bb^2+2*a/th*x)/(pi*a^2);      % Spreading resistance from  micripillar to water interface [K/W]
Rc=hSi/kSi*(a^2/bb^2+2*a/th*x)/(pi*a^2);  % Constriction resistance from pot plate to micripillar [K/W]
Rw=th/(kw*b^2);                            %thermal resistance of the assumed water layer
RSi=th/(kSi*b^2);                            %thermal resistance of the assumed water layer
C1=b^2/(pi)*(R2+Rs+Rc-Rw);
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
%b^2*(R2+Rs+Rc-Rw)





