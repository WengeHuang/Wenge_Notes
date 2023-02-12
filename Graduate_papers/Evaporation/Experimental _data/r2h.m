
%relation between droplet radius and droplet height
function [a] = r2h(h,rc,ca)  % h and rc have a internal relation, if h is from 0 to 1, then rc=1/tan(ca/2)
R=rc/sin(ca);    %radius of droplet
H=rc*tan(ca/2);  %height of droplet
h1=H-h;
a1=sqrt(R^2-(R-h1)^2);
a2=sqrt(R^2-(h+1/tan(ca))^2);
if ca<pi/2
    a=a2;
else
    a=a1;
end
end

