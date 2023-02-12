clc;
clear;
D=xlsread('Time_radius_square.xlsx',2);
[r,c]=size(D);              
t=zeros(r,1);
R=zeros(r,1);
Rs=zeros(r,1);  %R square
V=zeros(r,1);
sV=zeros(r,1);  % sqrt of V
CA=zeros(r,1);
i=1:1:r;
t(i)=D(i,2);
R(i)=D(i,3);
Rs(i)=D(i,4);
V(i)=D(i,5);
sV(i)=D(i,6);
CA(i)=D(i,7);
%plot(t,Rs,'*-',t,R,'o-'); %plot out the true volume with time
%plot(t,V,'o-',t,sV,'*-'); %plot out the true volume with time
%plot(t,Rs,'o-',t,sV,'*-'); %plot out the true volume with time
%subplot(1,2,1);
plot(t,R,'o-'); %plot out the true volume with time
grid on;
%subplot(1,2,2);
%plot(t,V,'*-');
hold on;
grid on
%plotyy(t,Vp,t,R)
title('20-60-40');
xlabel('t/t0');
ylabel('R^2');







