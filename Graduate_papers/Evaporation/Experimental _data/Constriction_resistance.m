clc;
clear;
%format long        %this just show all the digitals of the number 
% there is a digital problem for this calculation
% in expression calculation, 16-40 and 20-50 should be very similar
% x=0.2592 for 20-40 0.306 for 20-50, 0.338 for 20-60
x=0.2592;          %infinite summation of the Bessel function, related to a/b
th=1000*10^(-6);   %thickness of the substrate [m]
hv=0.1*10^(-6);      %thickness of the substrate [m]
w=20*10^(-6);      %diameter of the micropillar [m]
p=60*10^(-6);      %periodicity of the micropillar [m]
hs=40/1000000;     %height of micropillar [m]
a=w/2;             % radius of the micropillar
bb=sqrt(p*p/pi);    % radius of the equivalent periodicity
kSi=100;           %conductivity of Si W/(mK)
kw=0.679;          %conductivity of water W/(mK)
kv=0.025;          %conductivity of vapor W/(mK)
k=kw;
Rs=th/k*(a^2/bb^2+2*a/th*x)/(pi*a^2)      % Spreading resistance from pot plate to micripillar [K/W]
%Rsx=th/k*(a^2/b^2)/(pi*a^2)*p^2
Rc=th/kSi*(a^2/bb^2+2*a/th*x)/(pi*a^2);   % Constriction resistance from pot plate to micripillar [K/W]
R2=hs/(kSi*pi*w^2/4);                     %thermal resistance of the micropillar
Rw=th/(kw*p^2)                            %thermal resistance of the micropillar
Rv=hv/(kv*a^2*pi)                            %thermal resistance of the micropillar
% rho*(V(1)-V(2))/(t(2)-t(1))*L=0.1640 [W] evaporation of the droplet at
% the begining
% pi*R(1)^2/b^2 =644  number of unit under the droplet
q=0.35/638;      % heat flux through each micropillar underneath the droplet [W]
%dT1=R*q            % temperature difference between hot plate and begining of the micropillar [K]
dT2=R2*q;           % temperature difference between the two ends of micropillar [K]
rho=1000;          % water density kg/m^3
rhos=2329;         % Silicon density kg/m^3
cps= 710;         % specific heat of silicon [J/(kg K)]
cpw= 4182;         % specific heat of water [J/(kg K)]
%(sqrt(kSi*rhos*cps)*(120+273.15)+sqrt(kw*rho*cpw)*(20+273.15))/(sqrt(kSi*rhos*cps)+sqrt(kw*rho*cpw))-273.15
%sqrt(kw*rho*cpw)
(Rs-Rw)
%(Rsx-Rw)*p^2
(Rs-Rw+R2+Rc)*q
%a^2/b^2+2*a/th*x
t=1:1:20;
y=cosh(t)-sinh(t);
plot(t,y)


