%thermal conductivity fitted from 10 °„C to 99.6 °„C
%T is in °„C
function [ k ] = k_w(T)

k=(3.2093*10^(-5)*T^3-0.0142*T^2+2.3023*T+557.1877)/1000;  %W/(mK)

end

