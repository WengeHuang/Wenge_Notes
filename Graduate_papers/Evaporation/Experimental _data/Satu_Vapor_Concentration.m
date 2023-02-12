%temperature [C¡ã] vs saturated vaper concentration [kg/m^3],but it always
%written as g/mm^3, for example at 25C¡ãcs = 2.32 x 10 ^(-8) g/mm^3
% also the vapor diffusivity D is 26.1 mm^2/s
clc;
clear;
% T=[0,10,20,30,40,50,60,70,80,90,100,120,140];
% TT=transpose(T);
% cs=[0.005,0.009,0.017,0.03,0.051,0.083,0.13,0.20,0.29,0.42,0.59,1.1,1.8];
% css=transpose(cs);
% f1=fit(TT,css, 'exp1');
% f2=polyfit(TT,css,3);
% %plot(T,cs,'*')
% hold on 
% i=1:1:13;
% f3=9.7494*10^(-7)*T(i).^3-5.8152*10^(-5)*T(i).^2+0.0021*T(i)-0.0022; %[kg/m^3]
% %plot(T,f3)
% grid on
% 
% Ti=23+273.15;
% csw=9.7494*10^(-7)*(Ti-273.15)^3-5.8152*10^(-5)*(Ti-273.15)^2+0.0021*(Ti-273.15)-0.0022 %[kg/m^3]
% 
% TTT=[10 20 30 40 50 60 70 80 90 99.6];
% k=[578.64 598.03 614.50 628.56 640.60 650.91 659.69 667.02 672.88 677.03];
% %plot(TTT,k,'*')
% f4=polyfit(TTT,k,3);
% i=1:1:10;
% %kk=f4(1)*TTT(i).^3+f4(2)*TTT(i).^2+f4(3)*T(i)+f4(4)+23; %[kg/m^3]
% %plot(TTT,kk,'-')
% %kkk=3.2093*10^(-5)*TTT(i).^3-0.0142*TTT(i).^2+2.3023*TTT(i)+557.1877+23; %[kg/m^3]
% %plot(TTT,kkk,'o')
% %for i=1:1:10
% %    k(i)=1000*k_w(TTT(i));
% %end
% %plot(TTT,k,'-')
% 
% TTTT=[10 20 30 40 50 60 70 80 90 100];
% rho=[999.70 998.21 995.65 992.22 988.04 983.2 977.76 971.79 965.31 958.35];
% plot(TTTT,rho,'*')
% f5=polyfit(TTTT,rho,3);
% %rhoo=f5(1)*TTTT(i).^3+f5(2)*TTTT(i).^2+f5(3)*TTTT(i)+f5(4); %[kg/m^3]
% rhoo=1.2692*10^(-5)*TTTT(i).^3-0.0054*TTTT(i).^2-0.0076*TTTT(i)+1000.3; %[kg/m^3]
% %plot(TTTT,rhoo,'-')
% 
% %for i=1:1:10
% %    rhoo(i)=rho_w(TTTT(i));
% %end
% %plot(TTTT,rhoo,'-')
x=[0	0.1108585	0.1773736	0.221717	0.3104038	0.3547472	0.3990906	0.443434	0.8	1];
y6=[0.25962995	0.253682561	0.242649329	0.229795899	0.199044625	0.175776063	0.141931063	0.089792487	-0.059929583	-0.075467836];
plot(x,y6,'*')
hold on
f=fit(transpose(x),transpose(y6),'poly4')
plot(f,x,y6)



