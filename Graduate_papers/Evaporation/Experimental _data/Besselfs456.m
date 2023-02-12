%calculate the summation of Bessel series at the liquid-solid interface
function [B] = Besselfs456(x,p)
if p==6
    p1 =     -0.2247 ;
    p2 =      0.1046 ;
    p3 =    -0.05385 ;
    p4 =       0.341 ;
elseif p==5
    p1 =     -0.2276;
    p2 =      0.1104 ;
    p3 =    -0.05474 ;
    p4 =      0.3142 ;
elseif p==4
    p1 =     -0.2335;
    p2 =       0.122 ;
    p3 =     -0.0565  ;
    p4 =      0.2605 ;
end
    B=p1*x^3 + p2*x^2 + p3*x + p4;

end
%fitting for 6P
% x=[0 0.25 0.4 0.5 0.7 0.8 0.9 1];
% y6=[0.340158554	0.333252245	0.322387004	0.308523195	0.275763305	0.251421465	0.217270463	0.16443348];
% plot(x,y6,'*')
% hold on
% f=fit(transpose(x),transpose(y6),'poly3')
% plot(f,x,y6)

%fitting for 5P
% x=[0 0.25 0.4 0.5 0.7 0.8 0.9 1];
% y6=[0.313315686	0.306729017	0.295807779	0.282280763	0.250190412	0.226206331	0.19215733	0.139553149];
% plot(x,y6,'*')
% hold on
% f=fit(transpose(x),transpose(y6),'poly3')
% plot(f,x,y6)

%fitting for 4P
% x=[0 0.25 0.4 0.5 0.7 0.8 0.9 1];
% y6=[0.25962995	0.253682561	0.242649329	0.229795899	0.199044625	0.175776063	0.141931063	0.089792487];
% plot(x,y6,'*')
% hold on
% f=fit(transpose(x),transpose(y6),'poly3')
% plot(f,x,y6)



