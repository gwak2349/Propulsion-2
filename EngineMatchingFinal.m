%% Assignment 1
% This files provides a general framework to match engine-aircraft and
% propeller
% it relies on you supplying the correct propeller data and only gives some
% pointers to matching engine and propeller
clear
close all
clc

%% Set up the flight conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% unless you want to use sea level change the flight conditions

% Sea Level as an example - update to your flight conditions
FlightCondition.Pressure     	= 101325;   % Pa
FlightCondition.Temperature   	= 288.15;   % K
FlightCondition.R              	= 287.05;   % Gas constant for air
FlightCondition.Density     	= FlightCondition.Pressure/...
    FlightCondition.R/FlightCondition.Temperature;
FlightCondition.g               = 9.80665;  % m/s^2
FlightCondition.RoC             = 0;        % Rate of Climb in m/s

%% Set up the aircraft drag calculation
FlightSpeed.Vmin                = 5;        % Min flight speed - do not use 0 or your drag will shoot through the roof
FlightSpeed.Vmax                = 40;       % Max flight speed
FlightSpeed.NrOfPoints          = 100;      % increase to refine if needed
FlightCondition.Speed           = linspace(FlightSpeed.Vmin,FlightSpeed.Vmax,FlightSpeed.NrOfPoints);

FlightCondition.ClimbAngle      = atan(FlightCondition.RoC./FlightCondition.Speed);
FlightCondition.DynPressure     = FlightCondition.Density.*FlightCondition.Speed.^2/2;

%% Aircraft Specs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is where you need to enter the aircraft characteristics and
% calculate drag and thrust required


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intermediate plots as sanity check
% plot required thrust (drag) as function of flight speed


%% Propeller data
% I strongly recommend you to run your blade element code first and load
% the data here only AFTER you have verified you get sensible results
filenameprop                    = 'testprop.mat'; % data will be save under this name. Change as appropriate
load(filenameprop)
% convert to shorter notation
n                               = Propeller.RotSpeed;
dia                             = Propeller.Diameter;
J                               = Propeller.AdvanceRatio;
eff                             = Propeller.Efficiency;
t                               = Propeller.ThrustCoeff;
q                               = Propeller.TorqueCoeff;
rho                             = FlightCondition.Density;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% consider removing the NaNs from your blade element data or turn warnings
% off for interp1


%% Engine data
% load engine data and match it to the propeller here
[EngineMap] = EngineSpecs(FlightCondition);

% This gives a skeleton for a single throttle setting (full throttle)
% consider looping through a few throttle settings 
Throttle        = 100; % percentage
RPMrow          = round(length(EngineMap.RPM(:,1))/100*Throttle); % linear mapping with throttle
EngineRPM       = EngineMap.RPM(RPMrow,:);
EnginePower     = EngineMap.Power(RPMrow,:);
EngineTorque    = EngineMap.Torque(RPMrow,:);
EngineFuelFlow  = EngineMap.FuelFlow(RPMrow,:);
nvec          	= EngineRPM/60;        % as prop coeff are given as function of n and not RPM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% you should set up a few different throttles - but learn to walk before
% you run - check one throttle first


% now match the engine with the propeller for the different flight speeds
for cntrV = 1:length(FlightCondition.Speed)
    Speed                   = FlightCondition.Speed(cntrV);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % calculate the advance ratio vector as per the Assignment instructions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % interpolate the torque and thrust coefficients

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % convert coefficients into absolute values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % find intersection between propeller and engine torque

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% YOU NEED TO DO SOMETHING HERE %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % store the variables you want to plot. Consider plotting extra help
    % variables like engine torque and propeller torque of your matched
    % point so that you can check how good the matching worked

end

%% Generate plots for the report