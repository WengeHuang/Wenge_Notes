%Finite Element Method HW#1
clear;
clc;
format long
% test function
ph1 = @(x) sin(x);
ph2 = @(x) x;
ph1d = @(x) cos(x);
ph2d = @(x) 1;

%trial function
ps1 = @(x) cos(x);
ps2 = @(x) exp(x);
ps3 = @(x) x;
ps1d = @(x) -sin(x);
ps2d = @(x) exp(x);
ps3d = @(x) 1;

M = zeros (3,3);
M (1, :)=[ps1(0), ps2(0), ps3(0)];
tmp21 = @(x) ph1d(x).*ps1d(x)+ph1(x).*ps1d(x)+ph1(x).*ps1(x);
M(2,1) = integral (tmp21, 0, 1);
tmp22 = @(x) ph1d(x).*ps2d(x)+ph1(x).*ps2d(x)+ph1(x).*ps2(x);
M(2,2) = integral (tmp22, 0, 1);
tmp23 = @(x) ph1d(x).*ps3d(x)+ph1(x).*ps3d(x)+ph1(x).*ps3(x);
M(2,3) = integral (tmp23, 0, 1);
tmp31 = @(x) ph2d(x).*ps1d(x)+ph2(x).*ps1d(x)+ph2(x).*ps1(x);
M(3,1) = integral (tmp31, 0, 1);
tmp32 = @(x) ph2d(x).*ps2d(x)+ph2(x).*ps2d(x)+ph2(x).*ps2(x);
M(3,2) = integral (tmp32, 0, 1);
tmp33 = @(x) ph2d(x).*ps3d(x)+ph2(x).*ps3d(x)+ph2(x).*ps3(x);
M(3,3) = integral (tmp33, 0, 1);

f = @(x) (x+1).*(x+1) + x-2 -sin(x)+ 2*cos(x);
tmpr1 = @(x) ph1(x).*f(x);
rhs1 = integral(tmpr1, 0, 1);
tmpr2 = @(x) ph2(x).*f(x);
rhs2 = integral(tmpr2, 0, 1);

rhs = [1; ph1(1)*(3-sin(1))+rhs1; ph2(1)*(3-sin(1))+rhs2];
vu = M\rhs;

u_pg = @(x) vu(1)*ps1(x)+vu(2)*ps2(x)+vu(3)*ps3(x);

u_pg(pi/5.7)

x=0:0.01:1;
plot(x, u_pg(x));
xlabel('x');
ylabel('upg');



    