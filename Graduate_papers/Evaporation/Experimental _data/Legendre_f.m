
%Legendre Function
function [P] = Legendre_f(a,t)
e=10^(-4);
dkc=0.002;
p1=2/pi*coth(pi*t);
p2=0;
for kc=a+e:dkc:11-(a+e)
    b=sin(t*kc)/sqrt(2*cosh(kc)-2*cosh(a))*dkc;
    p2=p2+b;
end
P=p1*p2;
end

