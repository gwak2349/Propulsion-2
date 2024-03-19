clc

close all

d = Propeller2000.Diameter;


J1 = Propeller2000.AdvanceRatio;
n1 = Propeller2000.RotSpeed;
eff1 = Propeller2000.Efficiency;
t1 = Propeller2000.ThrustCoeff;
q1 = Propeller2000.TorqueCoeff;
thr1 = Propeller2000.Thrust;

p1 = 2*pi*q1;
pow1 = p1*n1^3*d^5;
V1 = J1*n1*d;

J2 = Propeller5000.AdvanceRatio;
n2 = Propeller5000.RotSpeed;
eff2 = Propeller5000.Efficiency;
t2 = Propeller5000.ThrustCoeff;
q2 = Propeller5000.TorqueCoeff;
thr2 = Propeller5000.Thrust;
p2 = 2*pi*q2;
pow2 = p2*n2^3*d^5;
V2 = J2*n2*d;

J3 = Propeller8000.AdvanceRatio;
n3 = Propeller8000.RotSpeed;
eff3 = Propeller8000.Efficiency   ;
t3 = Propeller8000.ThrustCoeff   ;
q3 = Propeller8000.TorqueCoeff ;
thr3 = Propeller8000.Thrust ;

p3 = 2*pi*q3;
pow3 = p3*n3^3*d^5;
V3 = J3*n3*d;

Jmax  = max(J2);
Tmax  = max(t1);
 
figure
plot(J1,t1, J2, t2, J3, t3)
grid on
title('Thrust Coefficients')
xlabel('Advance Ratio (J)');
ylabel('Ct');
lgd = legend('RPM=2000', 'RPM=5000', 'RPM=8000','Location','northeast');
fontsize(lgd,'decrease')
axis([0 Jmax 0 1.1*Tmax ]);


figure(2)
plot(J1,p1, J2, p2, J3, p3)
grid on
title('Power Coefficients')
xlabel('Advance Ratio (J)');
ylabel('Cp');
lgd = legend('RPM=2000', 'RPM=5000', 'RPM=8000','Location','best');
fontsize(lgd,'decrease')
axis([0 Jmax 0 1.5*Tmax ]);


figure(3)
hold on
grid on
plot(J1,eff1, J2, eff2, J3, eff3) 
title('Propeller Efficiency');
xlabel('Advance Ratio (J)');
ylabel('Efficiency');
lgd = legend('RPM=2000', 'RPM=5000', 'RPM=8000','Location', 'northwest');
fontsize(lgd,'decrease')
axis([0 Jmax 0 1 ]);
dim = [.2 .5 .3 .3];

figure(4)
hold on
grid on
yyaxis left
plot(J1, thr1, J2, thr2, J3, thr3)
xlabel("Advance ratio")
ylabel("Thrust")

yyaxis right
plot(J1, pow1, J2, pow2, J3, pow3)
ylabel("Power")
lgd = legend('RPM=2000', 'RPM=5000', 'RPM=8000','RPM=2000', 'RPM=5000', 'RPM=8000','Location','best');
fontsize(lgd,'decrease')

figure(5)
hold on
grid on
yyaxis left
plot(V1, thr1, V2, thr2, V3, thr3)
xlabel("Flight speed")
ylabel("Thrust")


yyaxis right
plot(V1, pow1, V2, pow2, V3, pow3)
ylabel("Power")
lgd = legend('RPM=2000', 'RPM=5000', 'RPM=8000','RPM=2000', 'RPM=5000', 'RPM=8000','Location','best');
fontsize(lgd,'decrease')

