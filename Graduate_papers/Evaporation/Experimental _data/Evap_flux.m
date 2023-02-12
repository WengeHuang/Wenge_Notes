%evaporation flux at different height with different contact angle
% the expression is for normalized evaporative flux
% need to divide tan(ca/2)
% we use h as the variable and h is from 0 to 1
function [ J ] =Evap_flux(h,ca)
R=h/(tan(ca/2)*sin(ca));
rc=1/tan(ca/2);

A1=-0.29*ca*ca+1.94*ca-1.34;
k=1+31.86*exp(-3.54*ca);
b=0.61*ca*ca-2.12*ca+6.16;
L1=3*(0.5-ca/pi);
J1=(A1*(k-exp(-b*h))^(-L1))/tan(ca/2);    %this part is just valid for contact angle larger than 90бу

A2=(0.27*ca*ca+1.3)*(0.6381-0.2239*(ca-pi/4)^2);
L2=0.5-ca/pi;
J2=A2*(1-(r2h(h*tan(ca/2),1,ca)/1)^2)^(-L2);
if ca<pi/2
    J=J2;
else
    J=J1;
end


end

