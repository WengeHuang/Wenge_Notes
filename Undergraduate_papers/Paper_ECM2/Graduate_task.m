clear
clc
%地热水：
fluid='R245fa';                                    %ORC工质都选用R245fa
T1=130+273.15;                                     %热源入口温度T1为130℃
P1=500;                                            %热源压力P1为要给定
M1=36.11;                                          %总水流量kg/s
Tpinch=10;                                         %节点温差Tpinch为15K
P3=1000;                                           %工质经过增压泵后的压力为1000kPa
P4=P3;                                             %工质在蒸发器出口的压力
H1=refpropm('H','T',T1,'P',P1,'water');            %热源进口的焓值
Ts=refpropm('T','P',P3,'Q',0,fluid);               %工质在蒸发器中节点的温度Ts
Tgs=Ts+Tpinch;                                     %热源在蒸发器中节点的温度Tgs
Hgs=refpropm('H','T',Tgs,'P',P1,'water');          %热源在蒸发器中节点的焓值为hgs
Hs=refpropm('H','P',P3,'Q',0,fluid);               %工质在节点的焓值
T4=Ts+10;                                          %过热度为20
H4=refpropm('H','T',T4,'P',P3,fluid);              %工质在蒸发器出口焓值为H4
M3=M1*(H1-Hgs)/(H4-Hs);                             %蒸发器产生蒸汽质量流量M3
Te=273.15+5;                                       %环境温度为5℃
T6=Te+5;                                           %工质在冷凝器出口的温度T1为25℃=Tenvi+5℃
P6=refpropm('P','T',T6,'Q',0,fluid);
H6=refpropm('H','T',T6,'Q',0,fluid);
s6=refpropm('S','T',T6,'Q',0,fluid);
H3s=refpropm('H','P',P3,'S',s6,fluid);
Xpump=0.70;                                        %假设供给泵的效率为80%
H3=(H3s-H6)/Xpump+H6;
T3=refpropm('T','P',P3,'H',H3,fluid);
H2=H1-M3/M1*(H4-H3);                               %热源排出时的焓值
T2=refpropm('T','H',H2,'P',P1,'water');          %热源排出时的温度
Qboil=M3*(H4-H3);                                %工质在蒸发器中吸热Qboil
%透平：
Xturb=0.76;                                     %假设汽轮机的效率为70%
s4=refpropm('S','T',T4,'P',P3,fluid);           %汽轮机进口熵
H5s=refpropm('H','P',P6,'S',s4,fluid);          %汽轮机出口等熵焓
H5=H4-Xturb*(H4-H5s);                           %考虑透平效率的出口实际焓
P5=P6;
T5=refpropm('T','P',P5,'H',H5,fluid);
Wturb=M3*(H4-H5);                                %汽轮机输出功Wturb
%冷凝器：
Qcond=M3*(H5-H6);   
%供给泵：
Wpump1=M3*(H3-H6);
%总的循环：
Xtotal=(Wturb-Wpump1)/Qboil;
%冷凝器中水的质量流量
T7=Te;
T8=T7+5;                  %冷凝器进水为环境温度，出口水温升高5度
P7=101.3;
P8=P7;
H7=refpropm('H','T',T7,'P',P7,'water');
H8=refpropm('H','T',T8,'P',P8,'water');
Mc=M3*(H5-H6)/(H8-H7);         
%第一次供热60-40/45-35
T11=45+273.15;                  %供热用热水温度
T10=35+273.15;                  %供热回来热水温度，温差为10℃
P11=400;
P12=100;
P10=400;
H11=refpropm('H','T',T11,'P',P11,'water');
H10=refpropm('H','T',T10,'P',P10,'water');   %供热焓值
s10=refpropm('S','T',T10,'P',P10,'water');
s12=refpropm('S','T',T10,'P',P12,'water');
H12s=refpropm('h','P',P12,'S',s12,'water');
H12=H10-(H10-H12s)/Xpump;
T12=refpropm('T','H',H12,'P',P12,'water');
T13=45+273.15;                 %地热水流出后为45℃
H13=refpropm('H','T',T13,'P',P1,'water');
Qrq1=M1*(H2-H13);              %总的供热量，换热器的热损为3%
Mf1=Qrq1/(H11-H10);
Wpump2=Mf1*(H10-H12);
%--------
%s2=refpropm('S','T',T2,'P',P2,'R245fa');
%s3=refpropm('S','T',T4,'P',P3,'R245fa');
P2=P1;
s1=refpropm('S','T',T1,'P',P1,'water');
s2=refpropm('S','T',T2,'P',P2,'water');
s3=refpropm('S','T',T3,'P',P3,fluid);
s5=refpropm('S','T',T5,'P',P5,fluid);
s7=refpropm('S','T',T7,'P',P7,'water');
s8=refpropm('S','T',T8,'P',P8,'water');
s11=refpropm('S','T',T11,'P',P11,'water');
s13=refpropm('S','T',T13,'P',P1,'water');
%环境温度下工质和地热水的焓和熵
H01=refpropm('H','T',T7,'P',P7,'water');
s01=refpropm('S','T',T7,'P',P7,'water');
H02=refpropm('H','T',T7,'P',P7,fluid); 
s02=refpropm('S','T',T7,'P',P7,fluid);
%算火用
Ex1=(H1-H01)-T7*(s1-s01);
Ex2=(H2-H01)-T7*(s2-s01);
Ex3=(H3-H02)-T7*(s3-s02);
Ex4=(H4-H02)-T7*(s4-s02);
Ex5=(H5-H02)-T7*(s5-s02);
Ex6=(H6-H02)-T7*(s6-s02);
Ex7=(H7-H01)-T7*(s7-s01);
Ex8=(H8-H01)-T7*(s8-s01);
Ex9=Ex2;
Ex10=(H10-H01)-T7*(s10-s01);
Ex11=(H11-H01)-T7*(s11-s01);
Ex12=(H12-H01)-T7*(s12-s01);
Ex13=(H13-H01)-T7*(s13-s01);

CRF=0.06505;
ty=8000;
tt=1;
E1=Ex1*ty/10^9*M1*3600*tt;    %GJ/year
E2=Ex2*ty/10^9*M1*3600*tt;
E3=Ex3*ty/10^9*M3*3600*tt;
E4=Ex4*ty/10^9*M3*3600*tt;
E5=Ex5*ty/10^9*M3*3600*tt;
E6=Ex6*ty/10^9*M3*3600*tt;
E7=Ex7*ty/10^9*Mc*3600*tt;
E8=Ex8*ty/10^9*Mc*3600*tt;
E9=E2;
E10=Ex10*ty/10^9*Mf1*3600*tt;
E11=Ex11*ty/10^9*Mf1*3600*tt;
E12=Ex12*ty/10^9*Mf1*3600*tt;
E13=Ex13*ty/10^9*M1*3600*tt;

Wturby=Wturb*ty/10^9*3600;
Wpump1y=Wpump1*ty/10^9*3600;
Wpump2y=Wpump2*ty/10^9*3600;

%
%Y=[Y_well;Y_turb;Y_vg;Y_pump1;Y_cond;Y_he];
%Y_well=40;                            %mPts/h
%w_well=6000;
%Y_well=w_well*461.1/20/8000;
Y_well=19.5586;
w_turb=1000*4.9*(Wturb/1000000)^0.73;
Y_turb=w_turb*143.7/20/8000;
w_vg=1000*2.14*(Qboil/1000000)^0.7;         %这里放热量的单位应该是MW
Y_vg=w_vg*461.1/20/8000
w_pump=1000*(0.125*log(Wpump1/1000)-0.0415);
Y_pump1=w_pump*132.9/20/8000;
w_cond=1000*0.073*(Qcond/1000000)^0.99;
Y_cond=w_cond*28.1/20/8000;
w_he=1000*2.14*(Qrq1/1000000)^0.7;
Y_he=w_he*461.1/20/8000;
A1=[E1,0,0,0,0,0;0,0,(E5-E4),0,0,Wturby;(E2-E1),-E3,E4,0,0,0;0,E3,-E6,0,0,-Wpump1y;0,0,(E6-E5),E8,0,0;(E13-E2),0,0,0,(E11-E10),0];
Y=[Y_well*8000;Y_turb*8000;Y_vg*8000;Y_pump1*8000;Y_cond*8000;Y_he*8000];
X_b=inv(A1)*Y       %mPts/GJ

A_vg1=A_evaporator1('R245fa','water',M3,M1,H4,H1,Hgs,P3,P1);
A_vg2=A_evaporator2('R245fa','water',M3,M1,H3,Hs,Hgs,H2,P3,P1);
A_vg=A_vg1+A_vg2;
C_vg0=10^(4.3247-0.3030*log10(A_vg)+0.1634*(log10(A_vg))^2);
C_vg=638.1/397*(1.63+1.66)*C_vg0;

C_turb0=10^(2.7051+1.4398*log10(Wturb/1000)-0.1776*(log10(Wturb/1000))^2);
C_turb=638.1/397*3.5*C_turb0;

Q5=refpropm('Q','T',T5,'P',P5,fluid)
A_cond=A_condenser1('R245fa',Q5,M3,Mc,H5,H6,P5,H7,H8,P7);
C_cond0=10^(4.3247-0.3030*log10(A_cond)+0.1634*(log10(A_cond))^2);
C_cond=638.1/397*(1.63+1.66)*C_cond0;

C_pump10=10^(3.3892+0.0536*log10(Wpump1/1000)+0.1538*(log10(Wpump1/1000))^2);
C_pump1=638.1/397*(1.89+1.35*2.2)*C_pump10;

A_he=A_rfheating('water','water',Mf1,M1,H10,H11,T10,T11,T2,T13,P10,P1);
C_he0=10^(4.3247-0.3030*log10(A_he)+0.1634*(log10(A_he))^2);
C_he=638.1/397*(1.63+1.66)*C_he0;

C_pump20=10^(3.3892+0.0536*log10(Wpump2/1000)+0.1538*(log10(Wpump2/1000))^2);
C_pump2=638.1/397*(1.89+1.35*2.2)*C_pump20;

C_well=50*10^4/6.12;
Z_well=C_well*CRF;
Z_vg=C_vg*CRF;
Z_turb=C_turb*CRF;
Z_cond=C_cond*CRF;
Z_pump1=C_pump1*CRF;
Z_pump2=C_pump2*CRF;
Z_he=C_he*CRF;


A1=[E1,0,0,0,0,0;0,0,(E5-E4),0,0,Wturby;(E2-E1),-E3,E4,0,0,0;0,E3,-E6,0,0,Wpump1y;0,0,(E6-E5),E8,0,0;(E13-E2),0,0,0,(E11-E10),0];
Z=[Z_well;Z_turb;Z_vg;Z_pump1;Z_cond;Z_he];
%Y=[Y_well;Y_turb;Y_vg;Y_pump1;Y_cond;Y_he];
X_c=inv(A1)*Z      %GJ/Year

%GJ/year
X_d=[(E4-E5-Wturby)*7.1/8000,(E1+E3-E2-E4)*1.64/8000,(E5+E7-E6-E8)*7.1/8000,(Wpump1+E6-E3)*10.29/8000,(E9+E10-E11-E13)*1.64/8000]


c_product=(Z_well+Z_turb+Z_vg+Z_pump1+Z_cond+Z_he)/((Wturb+Qrq1)*3600*8000/10^9);   %单位是$/GJ
d_product=(Y_well*8000+Y_turb*8000+Y_vg*8000+Y_pump1*8000+Y_cond*8000+Y_he*8000)/((Wturb+Qrq1)*3600*8000/10^9);   %单位是mpts/GJ












