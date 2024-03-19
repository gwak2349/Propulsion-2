R2 = readxfoil("Naca4412Re500_1.dat");

R1 = readxfoil("Naca4412Re650_1.dat"); 


alpha_1 = R1(:,1);
CL_1 = R1(:,2);
CD_1 = R1(:,3);

plot(alpha_1, CL_1)

hold on 


alpha_2 = R2(:,1);
CL_2 = R2(:,2);
CD_2 = R2(:,3);

plot(alpha_2, CL_2)