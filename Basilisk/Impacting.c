#include "axi.h"
#include "navier-stokes/centered.h"
#include "two-phase.h"
#include "tension.h"
#include "view.h"
#include "reduced.h"  /* adding reduced gravity*/

f[left] = 0.;
u.t[left] = dirichlet(0.);
f[right] = 0.;
u.t[right] = dirichlet(0.);

double R = 1.;
double U = 1.;
int maxlevel = 6;
double temp = 5.;

int main(){
  mu2 = 1./30.; //gas phase
  mu1 = 100./30.; //liquid phase
  rho2 = 1.; //gas phase
  rho1 = 100;//liquid phase
  f.sigma = 500.;
  init_grid(1 << 7);
  L0 = 10;
  X0 = -L0/2;
  Y0 = 0.;
  double Bond = 0.308;  
  G.x = -Bond;
  
  run();
}

event init(i = 0){
  refine(sq(x) + sq(y) < sq(R + 0.25) && sq(x) + sq(y) > sq(R - 0.25) && level < maxlevel);
  fraction(f, sq(R) - sq(x) - sq(y));
  foreach()
    u.x[] = -f[]*U;
}

event print(i++){
  printf("t = %g, i = %d\n", t, i);
}


event adapt(i++)
  adapt_wavelet((scalar *){u,f}, (double []){0.02, 0.02, 0.001}, maxlevel);
  
  event viewer(t=0.05;t+=0.1;t<=temp){
  clear();
  //view(psi = -pi/2, theta = 0.1, phi = 0.2);
  view(psi = -pi/2);
  box();
  cells();
  draw_vof("f", lw = 3);
  draw_vof("f", filled = 1, fc = {0.9, 0.4, 0.2});
  mirror({0,1}) {
    draw_vof("f");
    draw_vof("f", filled = 1, fc = {0.9, 0.4, 0.2});
    squares("u.x",linear = true);
  }
  save("f.mp4");
}
