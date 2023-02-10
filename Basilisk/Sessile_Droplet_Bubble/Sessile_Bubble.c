#include "axi.h"
#include "tpccontact.h"
#include "compressible-tensionb.h"
#include "view.h"
#include "reduced.h"

//To set the contact angle, we allocate a height-function field and set the contact angle boundary condition on its tangential component.

vector h[];
double theta0 = 150.;
h.t[left] = contact_angle (theta0*pi/180.);
double p0,pg0;
double CFLac = 2.;
double rho1=1., rho2=10.;

int main()
{
  size (4);

//We use a constant viscosity.

  mu1 = 1.;
  mu2 = 1.;
  gamma1 = 1.4;
  gamma2 = 7.14;
  PI2 = 300;
  rho1 = 1.; 
  rho2 = 10.;
  
  double Bond = 0.0308;
  G.x = -Bond;

//We must associate the height function field with the VOF tracer, so that it is used by the relevant functions (curvature calculation in particular).

  f.height = h;

//We set the surface tension coefficient and run for the range of contact angles.

  f.sigma = 1.;
  N = 64;
  //for (theta0 = 15; theta0 <= 165; theta0 += 15)
  run();
}

event init (t = 0)
{
  fraction (f, (sq(x) + sq(y) - sq(0.6))*(sq(x) + sq(y) - sq(1.2)));
  p0 = 1.;
  pg0 = 1. + 2.*f.sigma/0.5;
  foreach(){
    frho1[] = 1.*f[];
    frho2[] = 1.*(1. - f[]);
    p[] = pg0*f[] + p0*(1. - f[]);
    q.x[] = 0.;
    q.y[] = 0.;
    fE1[] = p[]/(gamma1 - 1.)*f[];
    fE2[] = (1. - f[])*(p[] + gamma2*PI2)/(gamma2 - 1.);
  }
  boundary({frho1,frho2,p,q,fE1,fE2});
}

event stability(i++)
{
  
  foreach()
    {
      double cspeed;
       if(f[] <= 0.0001)
  	     cspeed = sqrt(gamma2*(p[]+PI2)/frho2[]*(1.-f[]));
  	   else if(f[] >= 0.9999)
  	     cspeed = sqrt(gamma1*(p[]+PI1)/frho1[]*f[]);
  	   else
  	     cspeed = max(sqrt(gamma2*(p0+PI2)),sqrt(gamma1*(pg0)));
  	     double dtmaxac = CFLac*Delta/cspeed;
  	   dtmax = min(dtmax,dtmaxac);
    }
}

 int count = 0.; 
event movie (t += 2./40){ 
   //view (psi = -pi/2, fov = 22.5796, quat = {0,0,0,1}, tx = -0.475266, ty = -0.463264, bg = {1,1,1}, width = 1200, height = 600, samples = 1); 
   view (psi = -pi/2, ty=-0.5);
   clear(); 
   draw_vof ("f", lw = 2); 
   squares ("p", linear = true); 
   box (notics = true); 
   cells(); 
   mirror ({0,1}) { 
      draw_vof ("f", lw = 2);
      draw_vof("f", filled = 1, fc = {0.9, 0.4, 0.2});
      squares ("unorm", linear = true); 
      box (notics = true); 
    } 
    
   char name_exp[50]; 
   sprintf(name_exp,"movie-%5.5d.mp4",(int)theta0); 
   save (name_exp); 
   count ++; 
} 

//event adapt(i++)
//  adapt_wavelet((scalar *){f}, (double []){0.001}, 8);
  
//At equilibrium (t = 10 seems sufficient), we output the interface shape and compute the (constant) curvature.
event print(i++){
  printf("t = %g, i = %d\n", t/40, i);
}

event end (t = 40.)
{
  output_facets (f, stdout);
  
  scalar kappa[];
  curvature (f, kappa);
  stats s = statsf (kappa);
  double R = s.volume/s.sum, V = 2.*statsf(f).sum;
  fprintf (ferr, "%d %g %.5g %.3g\n", N, theta0, R/sqrt(V/pi), s.stddev);
}  
  
  
  
  
  
