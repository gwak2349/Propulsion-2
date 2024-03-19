function [EngineMap] = EngineSpecs(FlightCondition)
% This function returns an engine map for a given flight condition. 
% [EngineMap] = EngineSpecs(FlightCondition)
% where FlightCondition is a structure that contains Pressure and
% Temperature (in Pa and K!!!)
% The EngineMap is a structure file with the following fields. Each field
% is a 1000x1000
% EngineMap.RPM                 % rotational speed in RPM
% EngineMap.Torque              % Torque in Nm
% EngineMap.Efficiency          % Efficiency
% EngineMap.Power               % Power in W
% EngineMap.FuelFlow            % FuelFlow in kg/s
% EngineMap.BSFC                % Brake Specific Fuel Consumption g/hr/kW

LHV      = 43.71e6;

load EngineDataNew                                 % loads a struct with the engine data


%% Altitude Effects

% Gagg-Farar constants 
D                       = 0.24;         % to account for power variation with altitude
E                       = 0.079;        % to account for BSFC variation
F                       = 1.117;        % to account for BSFC variation

sigma                   = FlightCondition.Pressure/287.05/FlightCondition.Temperature/1.225;
PowerFactor             = (sigma - D)/(1-D);
BSFCFactor              = sigma *(1-E)/(sigma^F-E);

EngineMap.BSFC          = EngineMap.BSFC.*BSFCFactor;
EngineMap.Power         = EngineMap.Power.*PowerFactor;

% now recalculate other properties - keep RPM range the same
EngineMap.Torque        = EngineMap.Torque*PowerFactor;
EngineMap.FuelFlow      = EngineMap.FuelFlow*BSFCFactor;
EngineMap.Efficiency    = EngineMap.Efficiency/BSFCFactor;

