%long program for droplet base average temperature and interfacial
%temperature can evaporation ratio calculation
clc;
clear;
D3=xlsread('Evaporation_rate.xlsx',8);   %read for time,contact radius, height, heat flux
[r3,c3]=size(D3); 
T_time=zeros(r3,1);
R_contactr=zeros(r3,1);
f_heatflux=zeros(r3,1);
H_height=zeros(r3,1);

T_interfac=zeros(r3,1);
T_base=zeros(r3,1);
k_ratio=zeros(r3,1);

ii=1:1:r3;

T_time(ii)=D3(ii,1);
R_contactr(ii)=D3(ii,3);
H_height(ii)=D3(ii,4);
f_heatflux(ii)=D3(ii,5);


for jj=16:1:16
%data already know  %*
a=10*10^(-6);                %a is the radius of pillar [m]
pp=40*10^(-6);               %pp should be the periodicity [m]
%b=pp/sqrt(pi)
j=70;             %j=40-4P        %j=50-5P   % j is used to determine the a/b ratio e.x. j=70 is for a/b = 0.4434 , j starts from 2 to 101
%f=0.02/640/(pi*a*a);         %heat flux [W/m^2]
f=f_heatflux(jj)/(pi*(R_contactr(jj)*10^(-3))^2/pp^2)/(pi*a*a);
%kw=0.66;                    %conductive heat transfer coefficient  W/(mK)
ker=(1.86+0.86*tanh(2.245*log10(600/30*H_height(jj)/H_height(1))));
kw=0.68;
%0.6 for water at 20��C   0.67 for water at 100C
%20��C-0.6
%0.61-40, 0.62-50, 0.63-60, 0.64-70,  0.65-80, 0.66-90, 0.68-100
kSi=100;                     %conductive heat transfer coefficient  W/(mK)
L1=1000*10^(-6);             %thickness of substrate [m]      
hs=40*10^(-6);               %height of the micropillar [m]

Rp=hs/(kSi*pi*a*a);          % thermal resistance of the micropillar
RSi=L1/(kSi*pp*pp);          % thermal resistance of the substrate
DT1=f*pi*a*a*(Rp+RSi);       % temperature difference from the micropillar and substrate
Ts=100+273.15;                % substrate temperature
Tp=Ts-DT1;                   % pillar top average temperature

ca=2*atan(H_height(jj)/R_contactr(jj));
%ca=125/180*pi;               %contact angle
caa=ca/pi*180;
FCA=9.745766505304835*10^(-10)*caa^5-3.454896016406514*10^(-7)*caa^4+4.622232096733822*10^(-5)*caa^(3)-0.00273576804331*caa^2+0.0751*caa+0.6587;
H=0.350;                       %Humilidity use0.25
rc=R_contactr(jj)*10^(-3);             %contact radius
Rdrop=ca/(4*pi*kw*rc);        %conductive thermal resistance of water droplet [K/W]
Df=26.1*10^(-6); %m^2/s`````````````
Latent=2.26*10^6;             %water latent heat J/kg

%k=0;                      %evaporation part from the base
for k = 0.3:0.005:0.4
%k=(r3-jj)/27*0.0037072;
%%%%% droplet base average temperature
D1=xlsread('Bessel_temperature_matlab.xlsx',1);
[r1,c1]=size(D1);              %dimension of D1 is (r x c) but the data change is (r-1 x c-1)
T1=zeros(r1-1,1);
i=1:1:r1-1;
T1(i)=D1(i+1,1);               % T is the data of the first column except the first number
P=zeros(1,c1-1);
i=1:1:c1-1;
P(i)=D1(1,i+1);               %P is the ratio of a and b a/b but need to become d/p
R1=zeros(r1-1,1);
%*j=70;                        % j is used to determine the a/b ratio e.x. j=70 is for a/b = 0.4434 , j starts from 2 to 101
i=1:1:r1-1;
R1(i)=D1(i+1,j);               % R is the results of the Bessel series functions for the j ratio a/b
p1=polyfit(T1,R1,3);            % T is the data of the first colume, T is the data of the j th colume
x1=linspace(T1(1),T1(r1-1));     % from 0 to 1
y1=polyval(p1,x1);              % y is the function for the function of R=f(T)
rr=P(j-1);                   %ratio of a b, r=a/b 
%*a=10*10^(-6);                %a is the radius of pillar [m]
b=a/rr;                      %b is the equivalent radius of the periodicity
%*kw=0.679;                    %conductive heat transfer coefficient  W/(mK)   
L=2/3.817*b;                 %thickness of water layer [m] minimum

%*f=0.2/640/(pi*a*a);         %heat flux [W/m^2]
%*kk=0.7;                      %evaporation part from the base
cc=k*f*a*a/(b*b-a*a);       %heat flux flows into the droplet
Te1=((f+cc)*(a^2/b^2)-cc)/kw*(L)+(f+cc)/kw*2*a*y1;  
%Assuming on the level L, temperature is uniform in r direction and is the
%value 0, then Te is the temperature profile on the pillar with radius a

%plot(x1*rr,Te1);

%hold on
Ta1=0;
for i=1:1:99
    Ta1=Ta1+(Te1(i)*((x1(i+1))^2-(x1(i))^2))/0.99^2;
end

%Ta1 is the average temperature on the pillar
% we have the area average temperature on the pillar. from 0 to a
% actually we have the temperature distribution from 0 to b

D2=xlsread('Bessel_temperature_matlab.xlsx',8);% is almost the same data but with two more columns
[r2,c2]=size(D2);              %dimension of D1 is (r x c) but the data change is (r-1 x c-1)
T2=zeros(r2-1,1);
i=1:1:r2-1;
T2(i)=D2(i+1,1);               % T is the data of the first column except the first number
%P2=zeros(1,c2-1);  they use the same P
i=1:1:c2-1;
%P2(i)=D2(1,i+1);               %P is the ratio of a and b a/b but need to become d/p
R2=zeros(r2-1,1);
%j=70;  they use the same j
i=1:1:r2-1;
R2(i)=D2(i+1,j);               % R is the results of the Bessel series functions for the j ratio a/b
T2=T2*P(j-1);                  % use the ratio r/a time rr to get r/b, notice that the maximum part is r=a which I only calculate a/b from 0.1 to 0.6
T2(r2-2)=0.8;                  % add one point at r=0.8b
T2(r2-1)=1;                    % add another point at r=b
p2=polyfit(T2,R2,3);            % T is the data of the first colume, T is the data of the j th colume
x2=linspace(T2(1),T2(r2-1));     % from 0 to 1
y2=polyval(p2,x2);              % y is the function for the function of R=f(T)
% use the same temperature function as before
Te2=((f+cc)*(a^2/b^2)-cc)/kw*(L)+(f+cc)/kw*2*a*y2;  
%Assuming on the level L, temperature is uniform in r direction and is the
%value 0, then Te is the temperature profile on the pillar with radius a

%plot(x2,Te2);

Ta2=0;
for i=1:1:99
    Ta2=Ta2+(Te2(i)*((x2(i+1))^2-(x2(i))^2))/0.99^2;
end
plot(x2,Ta2);
%Ta2 is the average temperature on the water base
Tb=Tp-(Ta1-Ta2);                      % average temperature at the droplet base  
%Tp-(Ta1-Ta2)-273.15
%%%%%% droplet interface temperature
%DDT=(1-k)*f*(pi*(R_contactr(jj)*10^(-3))^2/pp^2)*pi*a^2*Rdrop;         % temperature difference because of the water droplet resistancce
DDT=(1-k)*f_heatflux(jj)*Rdrop; 
%(1-k)*f*640*pi*a^2*Rdrop
Ti=Tb-DDT;       % temperature at the droplet interface

%%%%%%%%%%
%interfacial temperature
%Ti=68+273.15;
%%Tb-DDT-273.15
csw=9.7494*10^(-7)*(Ti-273.15)^3-5.8152*10^(-5)*(Ti-273.15)^2+0.0021*(Ti-273.15)-0.0022; %[kg/m^3]
%%mass concentration for water at temperature Ti
%a1=pi*rc*Df*(csw-H*csw)*Latent*FCA;
a1=pi*rc*Df*(csw-H*0.0243)*Latent*FCA;       %evaporation flux by diffusion driven
k1=1-a1/(f*(pi*(R_contactr(jj)*10^(-3))^2/pp^2)*pi*a^2);                    %evaporation part from ratio calculated by diffusion driven 
%%a2=(1-k1)*f*640*pi*a^2
%%%%%%%%%%%%%

%%%%%%%%%%%%%
%volume average temperature
%a2=(1-k)*f*(pi*(R_contactr(jj)*10^(-3))^2/pp^2)*pi*a^2;
%AA=(ca/2*[(tan(ca/2))^3/3+tan(ca/2)])-(-log(cos(ca/2))+1/3*((tan(ca/2))^2+log(cos(ca/2))));    % volume
%V=pi/3*rc^3*(2+cos(ca))*(1-cos(ca))^2/(sin(ca))^3;                                             %volume
%Tav=((Tb)*pi*rc^3/2*[(tan(ca/2))^3/3+tan(ca/2)]-a2*rc^2/4/kw*AA)/V;                                % volume average temperature
%csw=9.7494*10^(-7)*(Tav-273.15)^3-5.8152*10^(-5)*(Tav-273.15)^2+0.0021*(Tav-273.15)-0.0022; %[kg/m^3]
%a1=pi*rc*Df*(csw-H*0.0243)*Latent*FCA;       %evaporation flux by diffusion driven
%k1=1-a1/(f*(pi*(R_contactr(jj)*10^(-3))^2/pp^2)*pi*a^2);                    %evaporation part from ratio calculated by diffusion driven 

if abs(k1-k)<0.015
   break
end

end

%Tb-273.15
%Ti-273.15
%Ts-Ti
%k
%k1
T_interfac(jj)=Ti-273.15;
T_base(jj)=Tb-273.15;
k_ratio(jj)=(k+k1)/2;
end
subplot(2,2,1);
plot(T_time,T_interfac);
subplot(2,2,2);
plot(T_time,T_base);
subplot(2,2,3);
plot(T_time,k_ratio);
k_ratio(jj)
T_base(jj)
T_interfac(jj)



