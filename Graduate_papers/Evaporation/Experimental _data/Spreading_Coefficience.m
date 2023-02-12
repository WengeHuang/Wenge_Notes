%https://www.electronics-cooling.com/2004/05/simple-formulas-for-estimating-thermal-spreading-resistance/
clc;
clear;
%calculating the spreading coefficient
w=20/10^6;   %micropillar width m
p=40/10^6;   %unit cell width m
h=40/10^8;   %height of the micropillar m
%r1=sqrt(w*w/pi);  %the equivalent radii
%r2=sqrt(p*p/pi);  %transfer square to cycle
r1=w/2;  %the equivalent radii
r2=sqrt(p*p/pi);  %transfer square to cycle
e=r1/r2;         %dimensionaless source area
t=h/r2;          %Dimensionless plate thickness
hef=2.3*10^5;    %equivalent evaporation heat transfer coefficient
kSi=130; %conductivity of Si W/(mK)
kw=0.679;        %conductivity of water W/(mK)
Bi=hef*r2/kw;    %Biot number
la=pi+1/(e*sqrt(pi));
fi=(tanh(la*t)+la/Bi)/(1+la/Bi*tanh(la*t));
Fiave2=sqrt(pi)/4*(1-e)^(3/2)
Fiave=1/2*(1-e)^(3/2)*fi
%Fimax=e*t/sqrt(pi)+1/sqrt(pi)*(1-e)*fi
Fimax2=1/sqrt(pi)*(1-e)*fi
