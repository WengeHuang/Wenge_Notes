%Marangoni velocity
Ts=39.11;
Tb=38.94;
VV=zeros(100,1);
dadT=0.176*10^(-3);       % N/(mK)      differential of surface tension and temperature
u=0.282*10^(-3);          % Pa s        dynamic viscosity
v=dadT*(Ts-Tb)/u;         % m/s         velocity
% for i=1:1:100
%     VV(i)=dadT*(T_c(i)-T_c(i+1))/u;  
% end