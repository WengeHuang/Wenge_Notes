clear
clc
fluid3='R245fa';
T14=341;
P14=401;
[H14 S14]=refpropm('HS','T',T14,'P',P14,fluid3);

Q18=1;
T18=280;
[P18 H18 S18]=refpropm('PHS','T',T18,'Q',Q18,fluid3);

Q16=0;


T16=298;
[P16 H16 S16]=refpropm('PHS','T',T16,'Q',Q16,fluid3);

P15=P16;
H17=H16;
P17=P18;
[T17 S17 Q17]=refpropm('TSQ','P',P17,'H',H17,fluid3);

S19s=S16;
P19=P14/0.98;
H19s=refpropm('H','P',P19,'S',S19s,fluid3);

Xpump3=1;
H19=H16+(H19s-H16)/Xpump3;
[T19 S19]=refpropm('TS','P',P19,'H',H19,fluid3);


M14=1;  %������������



%---------����������----------
S14s=S14;                 %�������͹���
P14s=P18;
[T14s H14s Q14s]=refpropm('THQ','P',P14s,'S',S14s,fluid3);

X_expand=0.9;   %���Ч��Ϊ0.9
u14=0;
H14a=H14-X_expand*(H14-H14s);
u14a=sqrt(2*X_expand*(H14-H14s));  %��ܳ����ٶ�
P14a=P14s;
[T14a S14a Q14a]=refpropm('TSQ','P',P14a,'H',H14a,fluid3);

miu=0.2;
miua=0.5;
X_mix=0.9;         %���Ч��
X_compress=0.9;    %����ѹ��Ч��
flag=1;
while abs(miu-miua)>=0.00001;
    miu=(miu+miua)/2;
    u18m=(sqrt(X_mix))*u14a/(1+miu);  %��Ϻ��ٶ�
    H18m=(H14+miu*H18)/(1+miu)-(u18m^2)/2;
    P18m=P18;
    [T18m S18m Q18m]=refpropm('TSQ','P',P18m,'H',H18m,fluid3);
    
    S15s=S18m;
    P15s=P15;
    [T15s H15s Q15s]=refpropm('THQ','P',P15s,'S',S15s,fluid3);
    
    H15=(H15s-H18m)*X_compress+H18m;     %��ѹ�γ�����ֵ
    [T15 S15 Q15]=refpropm('TSQ','P',P15,'H',H15,fluid3);
    
    miua=sqrt(X_expand*X_mix*X_compress*(H14-H14s)/(H15s-H18m))-1;
    
    if flag>200
        Error=msgbox('����ʽ���������','error');
        break
    end
    flag=flag+1;
end

%�����֧·����

M18=M14*miu;
M17=M18;
Me=M14;     %������������
M19=M14;
M15=M14+M18;
M16=M15;


Q_cool=M18*(H18-H17);           %������
