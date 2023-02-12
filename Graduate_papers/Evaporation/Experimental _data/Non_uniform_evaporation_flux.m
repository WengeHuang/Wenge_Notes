clc;
clear;
%Evaporation flux for non-uniform temperature distribution
n=100;
J=zeros(n,1);
I=zeros(n,1);
R=zeros(n,1);
ca=2/3*pi;
a=tan(ca/2);   
for i=1:1:n;
    I(i)=-0.01+0.01*i;        %need to let the -0.009 become 0 when ca is small
    J(i)=Evap_flux(I(i),ca);   %here we use droplet height h from 0 to 1 to calculate the evaporative flux
                               %but we plot it with nondimensional radius
    %r_h(h,rc,ca)
    %I(i)=-0.01+0.01*i;
    R(i)=r_h(I(i),1/a,ca);
end
hold on
plot(R,I,'*-')
%for h from 0-1
%R=h/(tan(ca/2)*sin(ca));    % the radius of the droplet
dR=diff(R);
dI=diff(I);
dF=dI./dR;
%figure
%plot(dF)
S=0;
V=0;
for i=1:1:n-1
    %dS=2*pi*R(i)^2*dI(i)*sqrt(1+(dF(i))^2);
    dS=2*pi*(1/(tan(ca/2)*sin(ca)))*dI(i);
    S=S+dS;
    dV=pi*R(i)^2*dI(i);
    V=V+dV;
end
S2=2*pi*(1/(tan(ca/2)*sin(ca)))^2*(1-cos(ca));
S-S2
V2=pi/3*(1/(tan(ca/2)*sin(ca)))^3*(2+cos(ca))*(1-cos(ca))^2;
V-V2




