clc;
clear;
D=xlsread('Bessel_temperature_matlab.xlsx',5);
%2 is the data for z=0.9L height with L being the minimum 2/3.817*b
%3 is the data for z=0.5L
%4 is the data for z=0.1L
% L=5L
%5 z=0.98L
%6 z=0.9L
%7 z=0.8L
%9 z=0.75L
[r,c]=size(D);              %dimension of D
R=zeros(1,c-1);             % because of the first column, 
T=zeros(r-1,1);             % start from the second roll
RR=zeros(r-1,1);            % in the given ratio a/b RR is r/b
i=1:1:c-1;
R(i)=D(1,i+1);              % R is the first roll of D from 0.1 to 0.6 is the ratio a/b
% R is the first roll and starts from the second one
j=69;                        % j should be larger than 1 because the first roll is not bessel result
i=1:1:r-1;
T(i)=D(i+1,j);              % T is the result of Bessel function summation
RR(i)=D(i+1,1);             % RR is the ratio of r/b from 0 to 1 with distance 0.25
p=polyfit(RR,T,3);
x=linspace(RR(1),RR(r-1));
y=polyval(p,x);
%figure
%plot(RR,T,'*')
hold on
%plot(x,y)
%hold off
k=0.667;     %conductive heat transfer coefficient  W/(mK)
a=10*10^(-6);     %radius of pillar [m]
f=0.2/640/(pi*a*a);        %heat flux 
%b=1;    %radius of periodicity [m]
rr=R(j);     %ratio of a b, r=a/b 
b=a/rr;    
L=2/3.817*b*5;     %thickness of water layer [m] minimum
z=0.98*L;              %height [m]
S=y;     %summmation of the bessel functions
kk=0;
cc=kk*f*a*a/(b*b-a*a);
Te1=((f+cc)*(a^2/b^2)-cc)/k*(z)+(f+cc)/k*2*a*S;%;-13.7;      %temperature considering water conductivity
Te2=f/k*2*a*S*(b^2/(b^2-a^2));
plot(x,Te1)
%plot(x,Te1-Te1)

%xx=zeros(90,1);
%TT=zeros(90,1);
%for i=1:1:90
%    xx(i)=x(i);
%    TT(i)=Te1(i);
%end
%plot(xx,TT/25.1);    








