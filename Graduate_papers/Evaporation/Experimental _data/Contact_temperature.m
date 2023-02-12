%Contact temperature of liquid and solid interface
Tw=20+273.15;        % temperature of water  [K] 
Ts=100+273.15;       % temperature of solid surface  [K]
cw=4.185;            % specific heat of water [kJ/(kg K)]
rhow=998;            % density of water [kg/m^3]
kw=0.5978;           % thermal conductivity of water [W/(mK)]
cs=0.71;             % specific heat of silicon  [kJ/(kg K)]
rhos=2329;           % density of silicon 
ks=100;              % thermal conductivity of silicon  W/(mK)



b1=sqrt(cw*rhow*kw);
b2=sqrt(cs*rhos*ks);

Tc=(Tw*b1+Ts*b2)/(b1+b2)-273.15


