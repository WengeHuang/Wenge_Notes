%Saturated vapor concentration
function [ c ] = c_w(T)
%T is in °„C
c=9.7494*10^(-7)*T^3-5.8152*10^(-5)*T^2+0.0021*T-0.0022;  %[kg/m^3]
end

