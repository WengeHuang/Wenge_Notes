function [J] = Deegans_f(a,o)
%o=pi/2;
j=0;
e=10^(-4);
dt=0.002;
for t=e:dt:11
    b=cosh(o*t)/cosh(pi*t)*tanh((pi-o)*t)*Legendre_f(a,t)*t*dt;
    j=j+b;
end  
J=0.5*sin(o)+sqrt(2)*(cosh(a)+cos(o))^(3/2)*j;
end

