%% Comments
% This m-file is based on the file created by Doug Auld for the
% Aerodynamics for students.
% Additional comments have been added by Dries Verstraete to assist students in
% AERO3261/AERO9261 with their propeller assignment

clear;
close all
clc

filenameprop = 'testproprpm8000.mat'; % data will be save under this name. Change as appropriate
%% Propeller Geometry
% You need to update this to make it a vector of chord and pitch as
% function of radius. The data we will provide you in week 3 will be in the
% format of chordvec = []; and pitchvec = []. Where chord is in meters and pitch
% is an angle in degrees
% Note that pitch is given as a distance here!!

NrOfElements = 10;
chordvec = [27.20,34.82,41.61,43.82,42.15,37.69,31.95,24.35,18.68,13.46]/1000;
pitchvec = [1.0606,1.0606,0.8523,0.5630,0.4349,0.41,0.3840,0.3625,0.2851,0.245];


dia                 = 0.5334;      %diameter of the propeller
R                   = dia/2.0;  %tip radius


% [chordvec,pitchvec] = PropellerDimension(r1,PropellerName);


%% Blade segments
% use 10 blade segments (starting at 10% R (hub) to R)
xs                  = 0.1*R;
xt                  = R;
rstep               =(xt-xs)/(NrOfElements-1);
r1                  =(xs:rstep:xt);
% 

% you might need to update this to ensure you have the correct number of
% elements. I suggest to use the matlab length function to make sure your
% vectors are the correct length

%% Propeller operating conditions


% 
RPM                 = 8000;    %engine speed in RPM
n                   = RPM/60.0; %RPM --> revs per sec
omega               = n*2.0*pi;  %rps --> rads per sec
% SEA LEVEL - UPDATE FOR YOUR REAL FLIGHT CONDITIONS
p                   = 101325;
T                   = 288.15;
Rair                = 287.05;
rho                 = p/Rair/T;
mu                  = 1.458e-6*T^1.5/(T+110.4);

% Flight Speed Vector
Vmin                = 0.1; % do not use 0 as your BEM will not converge
Vmax                = 70; % adjust this to you get a better control over the speeds
NrOfVs              = 70; % length of Vvec - consider refining once your code works
Vvec                = linspace(Vmin,Vmax,NrOfVs);

%% Add your aerodynamic data here
filenames.Re50 = 'Naca4412Re50';
filenames.Re100 = 'Naca4412Re100';
filenames.Re200 = 'Naca4412Re200';
filenames.Re350 = 'Naca4412Re350';
filenames.Re500 = 'Naca4412Re500';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filenames.Re500 = "Naca4412Re500_1.dat";
filenames.Re650 = 'Naca4412Re650_1.dat'; % only uncomment once you have added
% % % %  % your own files!!
filenames.Re800 = 'Naca4412Re800_1.dat';
filenames.Re1000 = 'Naca4412Re1000_1.dat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
astall = -12.1; % is in degrees!!! - check this number

[alfa500,cl500,cd500,Remat,Cd0mat] = dragdata(filenames,astall);

%% Convergence criterion
% this gives the precision you want to obtain
accuracy            = 1e-3;

%% Initialisation to speed things up (allocation is slow in Matlab)

t                   = NaN(1,length(Vvec));
q                   = NaN(1,length(Vvec));
J                   = NaN(1,length(Vvec));
eff                 = NaN(1,length(Vvec));
icheck              = NaN(1,length(Vvec));
pow = NaN(1,length(Vvec));
thr = NaN(1,length(Vvec));
%% Actual calculations

for cntrV=1:length(Vvec)
    V                  = Vvec(cntrV); % flight speed
    %initialise sums
    thrust             = 0.0;
    torque             = 0.0;
    %loop over each blade element
    for j=1:size(r1,2)
        rad               = r1(j);          % select the radius of the element
        pitch = pitchvec(j);
        chord             = chordvec(j);    % select the chord of the element
        % calculate local blade element setting angle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        theta             = pitch;          % you need to convert to radians here if you did not do this before
        % guess initial values of inflow and swirl factor
        a                 = 0.1;
        b                 = 0.01;
        % some control on the iteration
        %set logical variable to control iteration
        finished          = false;
        %set iteration count and check flag
        sum               = 1;
        itercheck         = 0; % reset itercheck to zero for each calculation
        while (~finished) % iterate until the condition is met
            % axial velocity at the propeller disk
            V0              = V*(1+a);
            % disk angular velocity            
            V2              = omega*rad*(1-b);
            % flow angle
            phi             = atan2(V0,V2);
            %blade angle of attack
            alpha           = theta-phi;
            % Calculate reynolds number
            Vlocal          = sqrt(V0*V0+V2*V2);
            Re              = rho*chord*Vlocal/mu;
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % *** You will need to add your own files in lines 61 to 64 for it to work
            % properly *** & UPDATE ASTALL !!
            cl              = interp1(alfa500,cl500,alpha,'spline','extrap');
            cd              = interp1(alfa500,cd500,alpha,'spline','extrap');
            if alpha < alfa500(1)
                cl          = cl500(1);
                cd          = cd500(1);
            elseif alpha > alfa500(end)
                cl          = cl500(end);
                cd          = cd500(end);
            end
            factor          = interp1(Remat,Cd0mat,Re/500000,'spline','extrap');
            cd              = cd*factor;
            
            %% Calculate the element thrust and torque
            %thrust grading
            DtDr            = 0.5*rho*Vlocal*Vlocal*2.0*chord*(cl*cos(phi)-cd*sin(phi));
            %torque grading
            DqDr            = 0.5*rho*Vlocal*Vlocal*2.0*chord*rad*(cd*cos(phi)+cl*sin(phi));
            %% momentum check on inflow and swirl factors - use this to update inflow factors
            tem1            = DtDr/(4.0*pi*rad*rho*V*V*(1+a)); % this calculates a from eq 2.42
            tem2            = DqDr/(4.0*pi*rad*rad*rad*rho*V*(1+a)*omega); % and a_om from eq 2.46
            %stabilise iteration - this smooths out sharp fluctuations in a and b
            anew            = 0.5*(a+tem1);
            bnew            = 0.5*(b+tem2);
            %% Two ways to set convergence criterion
            %check for convergence - iterations have met the convergence criterion
            % better to make this a relative convergence criterion as discussed in
            % class
            if (abs((anew-a)/a)<accuracy)
                if (abs((bnew-b)/b)<accuracy)
                    finished      = true;
                end
            end
            a               = anew;
            b               = bnew;
            %increment iteration count
            sum             = sum+1;
            %check to see if iteration stuck - limit on number of iterations to
            %avoid it going in an infinite loop
            if (sum>500)
                finished       = true;
                itercheck      = 1; % set the flag to 1 so you know it did not converge
            end
        end
        %% if converged add it to the thrust
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % only add the DtDr and DqDr term if they are not infinite - see
        % the notes on divergence in the assignment handout here 

        if (isinf(a)||isinf(b)||isnan(a)||isnan(b))
            thrust = thrust;
            torque = torque;
        else
            thrust = thrust + DtDr*rstep;
            torque = torque + DqDr*rstep;
        end
        thrust            = thrust+DtDr*rstep;
        torque            = torque+DqDr*rstep;
    end
    %% Now calculate the total thrust, torque, ...
    t(cntrV)           = thrust/(rho*n*n*dia*dia*dia*dia);
    q(cntrV)           = torque/(rho*n*n*dia*dia*dia*dia*dia);
    J(cntrV)           = V/(n*dia);
    eff(cntrV)         = J(cntrV)/2.0/pi*t(cntrV)/q(cntrV);
    thr(cntrV) = thrust;
    
    icheck(cntrV)      = itercheck; % add a flag to see if it converged or not


end

% Jmax                = max(J);
% Tmax                = max(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% You might want to cut off values that are below zero!
ind1                = find (t<0);
ind2                = find (q<0);
ind                 = union(ind1,ind2);
% % now remove them from all the vectors
t(ind)              =[];
q(ind)              =[];
J(ind)              =[];
eff(ind)            =[];
pow(ind) = [];
thr(ind) = [];
icheck(ind)         =[];
Jmax                = max(J);
Tmax                = max(t);
%% plot the results - you need to make sure your figures are done properly so update here
% figure
% plot(J,t);
% grid on
% title('Thrust Coefficients')
% xlabel('Advance Ratio (J)');
% ylabel('Ct');
% legend('Ct');
% axis([0 Jmax 0 1.1*Tmax ]);
% 
% figure(2)
% plot(J,q);
% grid on
% title('Torque Coefficients')
% xlabel('Advance Ratio (J)');
% ylabel('Cq');
% legend('Cq');
% axis([0 Jmax 0 1.1*Tmax ]);
% 
% figure(3)
% hold on
% grid on
% plot(J,eff);
% plot(J,eff);   
% title('Propeller Efficiency');
% xlabel('Advance Ratio (J)');
% ylabel('Efficiency');
% axis([0 Jmax 0 1 ]);
% dim = [.2 .5 .3 .3];



%% save things in the correct format for the EngineMatching template
% make sure to adjust when running multiple rpms.
Propeller8000.AdvanceRatio  = J;
Propeller8000.Efficiency    = eff;
Propeller8000.ThrustCoeff   = t;
Propeller8000.TorqueCoeff   = q;
Propeller8000.Diameter      = dia;
Propeller8000.RotSpeed      = n;
Propeller8000.Thrust = thr;
save(filenameprop,'Propeller8000');