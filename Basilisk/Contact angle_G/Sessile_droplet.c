//#include "axi.h"
#include "navier-stokes/centered.h"
#include "two-phase.h"
#include "tension.h"
#include "view.h"
#include "reduced.h"
#include "contact.h"


//f[left] = 0.;
//u.t[left] = dirichlet(0.);\

//f[left] = 0.;
//u.t[left] = dirichlet(0.);




vector h[];
double theta0 = 165;
//u.n[left] = dirichlet(0.); // No flow through surface
//u.t[left] = dirichlet(0.); // No slip at surface
h.t[bottom] = contact_angle (theta0*pi/180.); // RC contact angle


//h.t[left] = contact_angle (theta0*pi/180.);

double R = 1.5;
double U = 1.;
int maxlevel = 8;
double temp = 10.;

int main(){
  mu2 = 1.; //gas phase
  mu1 = 100.; //liquid phase
  rho2 = 1.; //gas phase
  rho1 = 100;//liquid phase
  f.sigma = 100.;
  init_grid(1 << 8);
  L0 = 6;
  X0 = -L0/2;
  Y0 = 0.;
  double Bond = 0.308;
  G.y = -Bond*0;
  
  f.height = h;
  run();
}

event init(i = 0){
  refine(sq(x) + sq(y) < sq(R + 0.25) && sq(x) + sq(y) > sq(R - 0.25) && level < maxlevel);
  fraction(f, sq(R) - sq(x) - sq(y));
  //foreach()
    //u.x[] = -f[]*U*2.5;
}

event print(i++){
  printf("t = %g, i = %d\n", t, i);
}


event adapt(i++)
  adapt_wavelet((scalar *){u,f}, (double []){0.02, 0.02, 0.001}, maxlevel);
  
  event viewer(t=0.05;t+=0.1;t<=temp){
  clear();
  //view(psi = -pi/2, theta = 0.1, phi = 0.2);
  //view(psi = -pi/2, tx = 0.5);
  view( ty = -0.5);
  box();
  cells();
  draw_vof("f", lw = 3);
  draw_vof("f", filled = 1, fc = {0.9, 0.4, 0.2});
  //squares("p");
  //mirror({0,1}) {
    //draw_vof("f");
    //draw_vof("f", filled = 1, fc = {0.9, 0.4, 0.2});
    //squares("u.x",linear = true);
  //}
  save("f.mp4");
}


