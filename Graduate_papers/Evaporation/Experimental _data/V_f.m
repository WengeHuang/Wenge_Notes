%function fitting the droplet volume
%we fit it with a fifth order polynomial
function [V] =V_f(t,a1,a2,a3,a4,a5,a6)

V=a1*t^5+a2*t^4+a3*t^3+a4*t^2+a5*t+a6;

end

