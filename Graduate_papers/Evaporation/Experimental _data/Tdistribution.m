%nondimensional temperature with different contact at different height
function [T] = Tdistribution(h,ca)
x=h;
y=ca;
       p00 =      0.8738  ;
       p10 =     0.09218  ;
       p01 =    0.003821  ;
       p20 =      0.1709  ;
       p11 =    -0.00482  ;
       p02 =  -2.459e-05  ;
       p30 =     -0.2156  ;
       p21 =    0.002655  ;
       p12 =  -4.791e-07  ;
       p03 =   2.282e-08  ;
  T1= p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 + p30*x^3 + p21*x^2*y + p12*x*y^2 + p03*y^3;
  T2= p00+ p01*y +p02*y^2 + p03*y^3;
  T=T1/T2;
end

