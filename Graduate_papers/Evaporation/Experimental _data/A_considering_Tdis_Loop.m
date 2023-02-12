%Considering temperature distribution
clc;
clear;
Data=xlsread('Eva_rate_finitediff.xlsx',18);   %read for time,contact radius, height, heat flux
%Data=xlsread('Evaporation_rate_test.xlsx',2);
[r3,c3]=size(Data); 
t=zeros(r3,1);               %time
V=zeros(r3,1);               %volume
r=zeros(r3,1);               %contact radius      
H=zeros(r3,1);               %height
qs=zeros(r3,1);               %evaporation rate 
ca=zeros(r3,1);              %contact angle
c=zeros(r3,1);               %contact angle
cc=zeros(r3,1);               %contact angle
%assign the data into the matrix
i=1:1:r3;
t(i)=Data(i,1);              %[s]
V(i)=Data(i,2)*10^(-9);      %[m^3]
r(i)=Data(i,3)*10^(-3);      %[m]
H(i)=Data(i,4)*10^(-3);      %[m]
qs(i)=Data(i,5)*1;             %[W]
% for i=1:1:r3
%     cc(i)=2*atan(H(i)/sqrt(2*V(i)/(pi*H(i))-H(i)^2/3));
% end
c(i)=2*atan(H(i)./r(i));    % contact angle might not accurate
for ci=1:1:r3-1
    if c(ci+1)>c(ci)
        c(ci+1)=c(ci);
    end
    if c(ci+1)<pi/2
        c(ci+1)=pi/2;
    end
end
ca(i)=c(i)/pi*180;% [бу]
%this cycle is to calculate data at each time
Phi=zeros(r3,1);
TB=zeros(r3,1);
TAV=zeros(r3,1);
TTT=zeros(r3,1);
JC=zeros(r3,4);
for j=1:1:r3                      %%%%%%%%%%%%%%%%%%
    a=10*10^(-6);                %a is the radius of pillar [m]
    pp=40*10^(-6);               %pp should be the periodicity [m]
    N=pi*(r(j)-pp)^2/pp^2;            %number of unit cells
    %here we don't count the outside rim pillar
    qp=qs(j)/N;                  %heat transfer rate in one pillar [W]
    kSi=100;                     %conductive heat transfer coefficient  W/(mK)
    L1=1000*10^(-6);             %thickness of substrate [m]      
    hs=40*10^(-6);               %height of the micropillar [m]
    Rp=hs/(kSi*pi*a*a);          % thermal resistance of the micropillar  [K/W]
    RSi=L1/(kSi*pp*pp);          % thermal resistance of the substrate
    DT1=qp*(Rp+RSi);             % temperature difference from the micropillar and substrate
    Ts=120+273.15;                % substrate temperature
    %Tp=Ts-DT1;                   % pillar top average temperature
    Tp=ct_T(Ts,65);                  % pillar top is at the contact temperature
    kw=k_w(Ts-273.15-DT1);       % thermal conductivity of water at substrate temperature
    kwe=kw*2.5;                  % effective thermal conductivity in droplet thermal conduction
    hfg=h_fg(Ts-273.15);       %latent heat of water at substrate temperature

    for phi =0.4:0.0001:0.76
        if phi==0.9;
            phi=0;
        end
    %phi=0.3;                     %evaporation ratio at the droplet base
    %calculate droplet base interface average temperature
    b=pp/sqrt(pi);               %b is the equivalent radius of the periodicity
    Lw=2/3.817*b;                 %thickness of water layer [m] minimum
    qi=qp*(1-phi);                   %heat transfer into the droplet in one unit
    x1=linspace(0,1);             % r/a from 0 to 1
    y1=linspace(0,1);
    n=length(x1);
    for i=1:1:n
        y1(i)=Besselfs456(x1(i),6);%call the liquid_solid interfasce Bessel fitting function
    end
    T_bp=qp*Lw/(pi*kw)*(1-phi)/b^2+2*a*qp/(pi*kw)*(1/a^2+phi/(b^2-a^2))*y1;
    % temperature distribution in r direction at the liquid-solid interface
    Ta1=0;
    for i=1:1:99
    Ta1=Ta1+(T_bp(i)*((x1(i+1))^2-(x1(i))^2))/0.99^2;
    end
    x2=linspace(0,1);            % r/b from 0 to 1
    y2=linspace(0,1);
    for i=1:1:n
        y2(i)=Besselfb456(x2(i),6);%call the liquid_solid interfasce Bessel fitting function
    end
    T_bb=qp*Lw/(pi*kw)*(1-phi)/b^2+2*a*qp/(pi*kw)*(1/a^2+phi/(b^2-a^2))*y2;
    %temperature distribution in r direction at the droplet base
    Ta2=0;
    for i=1:1:99
        Ta2=Ta2+(T_bb(i)*((x2(i+1))^2-(x2(i))^2))/0.99^2;
    end
    Tb=Tp-(Ta1-Ta2);             % average temperature at the droplet base
    
    D=26.1*10^(-6);  %m^2/s  diffusion coefficient
    Hu=0.35;          %relative humidity
    nn=50;
    nh=zeros(nn,1);             %divid the droplet height into 100 parts
    nr=zeros(nn,1);             % contact radius corresponding to nondimensional h
    dS=zeros(nn,1);             % surface area
    R_l=zeros(nn+1,1);            % thermal resisitance of each layer
    J=zeros(nn+1,1);              % evaporation flux at each layer
    qin=zeros(nn+2,1);            % heat flux inside water droplet   
    %here we have nn+2, notice that the "+2", one is for the base and one
    %is for the up hemisphere
    Ti=zeros(nn+2,1);           %surface temperature at each layer
    qin(1)=qi*N;
    Ti(1)=Tb;  
%     for i=1:1:nn                 
%         nh(i)=1/nn*i;
%         dh=1/nn;
%         nr(i)=r2h(nh(i),1/tan(c(j)/2),c(j));  % radius of the droplet with respect to h
%         dS(i)=2*pi*(1/(tan(c(j)/2)*sin(c(j))))*dh*H(j)^2;% here 0.01 is dh 
%         R_l(i)=dh/(kwe*pi*nr(i)^2)/H(j);       % K/W   
%         %the only place to use effective thermal conductivity coefficient
%         rc=1/tan(c(j)/2)*H(j);
%         J(i)=D*(c_w(Ti(i)-273.15)-Hu*c_w(20))/rc*Evap_flux(nh(i),c(j))*dS(i)*hfg;  %  W
%         qin(i+1)=qin(i)-J(i);                 % rest heat flux  W
%         Ti(i+1)=Ti(i)-R_l(i)*qin(i+1);
%         Ti(nn+1)=Ti(nn);                  % the final T looks always bad, here we let it equal to the former one
%     end

% here we only divide the half part of the droplet into layers and 
    for i=1:1:nn 
        Hc=1-1/(sin(c(j))*tan(c(j)/2));       % we only calculate h from 0 to Hc, left hemisphere 
        nh(i)=Hc/nn*i;                         % divided that height
        dh=Hc/nn;
        nr(i)=r2h(nh(i),1/tan(c(j)/2),c(j));  % radius of the droplet with respect to h
        dS(i)=2*pi*(1/(tan(c(j)/2)*sin(c(j))))*dh*H(j)^2;% here 0.01 is dh 
        R_l(i)=dh/(kwe*pi*nr(i)^2)/H(j);       % K/W   
        %the only place to use effective thermal conductivity coefficient
        rc=1/tan(c(j)/2)*H(j);
        J(i)=D*(c_w(Ti(i)-273.15)-Hu*c_w(20))/rc*Evap_flux(nh(i),c(j))*dS(i)*hfg;  %  W
        qin(i+1)=qin(i)-J(i);                 % rest heat flux  W
        Ti(i+1)=Ti(i)-R_l(i)*qin(i+1);
        %Ti(nn+1)=Ti(nn);                  % the final T looks always bad, here we let it equal to the former one
    end
    Rup=sin(c(j))/(8*kw*rc);               % thermal resistance of the hemisphere
    R_l(nn+1)=Rup;
    Ti(nn+2)=Ti(nn+1)-Rup*qin(nn+1);
    Tup=Ti(nn+2);                          % surface temperature of the hemisphere used to compare with IR test
    J(nn+1)=D*(c_w(Ti(nn+2)-273.15)-Hu*c_w(20))*pi*(rc/sin(c(j)))*hfg;  % evaporative rate of the hemisphere
    
    R_w=atan(H(j)/r(j))/(2*pi*kw*r(j));
    
    T_c=Ti-273.15;
    JJ=sum(J);
    JJJ=(1-phi)*qs(j);
    if abs(JJ-JJJ)<0.0001
        break
    end
    
    end    
    Phi(j)=phi;
    TB(j)=Tb-273.15;
    %TAV(j)=sum(T_c)/nn;
    %TAV=
    TMAV=Ti(nn+2)*(1-Hc);  % for high temperature we calculate the whole average temperature
    for i=1:1:nn+1
        TMAV=TMAV+Ti(i)*1/nn*Hc;
    end
    TAV(j)=Tup-273.15;
    TTT(j)=TMAV-273.15;
    %TAV(j)=TMAV-273.15;
    JC(j,1)=JJ;
    JC(j,2)=phi*qs(j);
    JC(j,4)=JJJ;
    JC(j,3)=qs(j);
end







