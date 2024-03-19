clear;close all; clc

%%
myred           = [216 30 49]/255;
myblue          = [27 99 157]/255;
myblack         = [0 0 0]/255;
mygreen         = [0 128 0]/255;
mycyan          = [2 169 226]/255;
myyellow        = [251 194 13]/255;
mygray          = [89 89 89]/255;

% if you want to keep using the standard matlab color remove this
set(groot,'defaultAxesColorOrder',[myblack;myblue;myred;mygreen;myyellow;mycyan;mygray]);
alw             = 1;                        % AxesLineWidth
fsz             = 22;                       % Fontsize
lw              = 2.5;                        % LineWidth
msz             = 40;                       % MarkerSize

set(0,'defaultLineLineWidth',lw);           % set the default line width to lw
set(0,'defaultLineMarkerSize',msz);         % set the default line marker size to msz
set(0,'defaultLineLineWidth',lw);           % set the default line width to lw
set(0,'defaultLineMarkerSize',msz);         % set the default line marker size to msz


%% Reading data

r = linspace(0,1,10);
[chordvec1,pitchvec1] = PropellerDimension(r,'APC20x8');

disp(chordvec1)
disp(r)

[chordvec,pitchvec] = PropellerDimension(r,'APC21x14');

R1 = readxfoil("Naca4412Re650_1.dat"); 
R2 = readxfoil("Naca4412Re800_1.dat");

R3 = readxfoil("Naca4412Re1000_1.dat");
% R3_2 = readxfoil("Naca4412Re1000_2.dat");

alpha_1 = R1(:,1);
alpha_2 = R2(:,1);
alpha_3 = R3(:,1);




CL_1 = R1(:,2);
CD_1 = R1(:,3);

CL_2 = R2(:,2);
CD_2 = R2(:,3);

CL_3 = R3(:,2);
CD_3 = R3(:,3);

%% Chord distribution
hFig            = figure(1); clf;
set(gcf, 'Color', [1 1 1]);                 % Sets figure background
set(gca, 'Color', [1 1 1]);                 % Sets axes background
hold on
grid on
grid minor


plot(r,chordvec)
xlabel("$$ \frac{r}{R} $$", "Interpreter", "latex")
ylabel("Chord (m)")



box on
set(gca,'GridLineStyle','-')                            % set gridline and font properties
set(gca,'MinorGridLineStyle','-')
set(gca,'GridColor','k')
set(gca,'MinorGridColor','k')
set(findall(hFig, '-property', 'FontSize'), 'FontSize', fsz)




%% Pitch distribution
hFig            = figure(2); clf;
set(gcf, 'Color', [1 1 1]);                 % Sets figure background
set(gca, 'Color', [1 1 1]);                 % Sets axes background
hold on
grid on
grid minor

plot(r,pitchvec)
xlabel("$$ \frac{r}{R} $$", "Interpreter", "latex")
ylabel("Pitch (radians)")

box on
set(gca,'GridLineStyle','-')                            % set gridline and font properties
set(gca,'MinorGridLineStyle','-')
set(gca,'GridColor','k')
set(gca,'MinorGridColor','k')
set(findall(hFig, '-property', 'FontSize'), 'FontSize', fsz)



%% plotting C_L against alpha
hFig            = figure(3); clf;
set(gcf, 'Color', [1 1 1]);                 % Sets figure background
set(gca, 'Color', [1 1 1]);                 % Sets axes background
hold on
grid on
grid minor


% plot(alpha_0,CL_0)

plot(alpha_1,CL_1)
hold on
plot(alpha_2,CL_2)
plot(alpha_3,CL_3)
xlabel("$$\alpha$$ ($$^{\circ}$$)", "Interpreter", "latex")
ylabel("$$C_L$$", "Interpreter", "latex")
[hleg] = legend('Re=0.65e6','Re=0.8e6','Re=1e6');
set(hleg,'EdgeColor',hleg.Color);
set(hleg,'Location','best');
hold off

box on
set(gca,'GridLineStyle','-')                            % set gridline and font properties
set(gca,'MinorGridLineStyle','-')
set(gca,'GridColor','k')
set(gca,'MinorGridColor','k')
set(findall(hFig, '-property', 'FontSize'), 'FontSize', fsz)






%% Plotting C_d against alpha


hFig            = figure(4); clf;
set(gcf, 'Color', [1 1 1]);                 % Sets figure background
set(gca, 'Color', [1 1 1]);                 % Sets axes background
hold on
grid on
grid minor

plot(alpha_1,CD_1)
hold on
plot(alpha_2,CD_2)
plot(alpha_3,CD_3)
xlabel("$$\alpha$$ ($$^{\circ}$$)", "Interpreter", "latex")
ylabel("$$C_D$$", "Interpreter", "latex")
[hleg] = legend('Re=0.65e6','Re=0.8e6','Re=1e6');
set(hleg,'EdgeColor',hleg.Color);
set(hleg,'Location','best');
hold off

box on
set(gca,'GridLineStyle','-')                            % set gridline and font properties
set(gca,'MinorGridLineStyle','-')
set(gca,'GridColor','k')
set(gca,'MinorGridColor','k')
set(findall(hFig, '-property', 'FontSize'), 'FontSize', fsz)

%% Finding stall angle for Re=500000

R0 = readxfoil("Naca4412Re650_1.dat"); 
alpha_0 = R0(:,1);
CL_0 = R0(:,2);

hFig            = figure(5); clf;
set(gcf, 'Color', [1 1 1]);                 % Sets figure background
set(gca, 'Color', [1 1 1]);                 % Sets axes background
hold on
grid on
grid minor


% plot(alpha_0,CL_0)

plot(alpha_0,CL_0)
xlabel("$$\alpha$$ ($$^{\circ}$$)", "Interpreter", "latex")
ylabel("$$C_L$$", "Interpreter", "latex")
[hleg] = legend('Re=0.5e6');
set(hleg,'EdgeColor',hleg.Color);
set(hleg,'Location','best');
hold off

box on
set(gca,'GridLineStyle','-')                            % set gridline and font properties
set(gca,'MinorGridLineStyle','-')
set(gca,'GridColor','k')
set(gca,'MinorGridColor','k')
set(findall(hFig, '-property', 'FontSize'), 'FontSize', fsz)



