%Propulsion Propeller Dimensions 
%Beau Emmerson 2018

%Description: 
%Save PropellerDimension function/code in the same folder as your blade
%element code
%Call function in main code as: 
%[chord,pitch] = PropellerDimension(r1,PropellerName);
%Give the function your radial vector r1 with any amount of
%points/positions from R = 0.1 to 1.0 
%Give the function the propeller name with the propeller tested in your
%lab with a string in your main code as follows:
%PropellerName = 'APC20x8'; %Wednesday Week 1 4pm 
%PropellerName = 'APC20x10'; %Friday Week 1 2pm 
%PropellerName = 'APC20x12'; %Friday Week 1 4pm 
%PropellerName = 'APC22x8'; %Wednesday Week 2 4pm 
%PropellerName = 'APC22x12W'; %Friday Week 2 2pm 
%PropellerName = 'APC21x14'; %Friday Week 2 4pm
%PropellerName = 'APC24x12'; %Wednesday Week 3 4pm
%PropellerName = 'XOAR21x10'; %Friday Week 3 2pm 
%PropellerName = 'XOAR21x14'; %Friday Week 3 4pm

%You will get out of this function the chord and pitch at the given r1 locations
%Chord will be in metres and pitch will be in 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [chordvec,pitchvec] = PropellerDimension(r1,PropellerName)
if strcmp(PropellerName,'APC20x8')==1
    chordRaw = [27.9,34,40.3,42,41.2,38,32.7,26.7,20.4,12.4]/1000;
    pitchRaw = [0.59,0.59,0.462,0.337,0.255,0.225,0.206,0.204,0.203,0.201];
    radialRaw = [0.098,0.196,0.294,0.392,0.490,0.588,0.686,0.784,0.882,1.0];
end 

if strcmp(PropellerName,'APC20x10')==1
    chordRaw = [41,44.721,43.41,38.91,34.53,30.36,25.70,20.5,16.5,11.18]/1000;
    pitchRaw = [0.5463,0.5463,0.6167,0.5278,0.4301,0.3207,0.2447,0.22,0.2088,0.2];
    radialRaw = [0.098,0.196,0.294,0.392,0.490,0.588,0.686,0.784,0.882,1.0];
end 

if strcmp(PropellerName,'APC20x12')==1
    chordRaw = [39.29,41.04,41.04,39.11,36.23,32.00,27.00,23.00,18.02,11.41]/1000;
    pitchRaw = [0.8028,0.8028,0.8028,0.7389,0.5875,0.4391,0.38,0.37,0.3683,0.35];
    radialRaw = [0.098,0.196,0.294,0.392,0.490,0.588,0.686,0.784,0.882,1.0];
end 

if strcmp(PropellerName,'APC22x8')==1
    chordRaw = [43.41,46.95,48.07,44.19,40.16,35,29.73,24.04,18.68,12.16]/1000;
    pitchRaw = [0.5463,0.5463,0.5463,0.4256,0.3561,0.3063,0.275,0.245,0.21,0.1682];
    radialRaw = [0.0982,0.1964,0.2946,0.3928,0.4910,0.5892,0.6875,0.7857,0.8839,1.0];
end 

if strcmp(PropellerName,'APC22x12W')==1
    chordRaw = [31.04,37.21,44.1,48.54,49.21,46.17,41.62,35.90,28.44,19.41]/1000;
    pitchRaw = [0.7580,0.7580,0.7580,0.5028,0.3800,0.3293,0.2850,0.2326,0.1804,0.1550];
    radialRaw = [0.0982,0.1964,0.2946,0.3928,0.4910,0.5892,0.6875,0.7857,0.8839,1.0];
end 

if strcmp(PropellerName,'APC21x14')==1
    chordRaw = [27.20,34.82,41.61,43.82,42.15,37.69,31.95,24.35,18.68,13.46]/1000;
    pitchRaw = [1.0606,1.0606,0.8523,0.5630,0.4349,0.41,0.3840,0.3625,0.2851,0.245];
    radialRaw = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0];
end 

if strcmp(PropellerName,'APC24x12')==1
    chordRaw = [32.28,39.66,48.37,51.34,49.81,45.47,39.5,31.78,24.33,16.19]/1000;
    pitchRaw = [0.7868,0.7868,0.6429,0.4352,0.3267,0.2674,0.2245,0.2,0.1682,0.15];
    radialRaw = [0.0984,0.1968,0.2952,0.3937,0.4921,0.5905,0.6889,0.7874,0.88582,1.0];
end 

if strcmp(PropellerName,'XOAR21x10')==1
    chordRaw = [33.28,37,41.14,42.6,42.72,40.26,35,27.45,20.30,12.16]/1000;
    pitchRaw = [0.7868,0.7868,0.5288,0.4,0.3013,0.2621,0.2136,0.1873,0.1768,0.168];
    radialRaw = [0.1,0.2308,0.3308,0.4308,0.5308,0.6308,0.7308,0.8308,0.9308,1.0];
end 

if strcmp(PropellerName,'XOAR21x14')==1
    chordRaw = [36.61,40.36,43.82,46.52,49.04,46.81,41.90,36.01,25.49,14.22]/1000;
    pitchRaw = [1.2601,1.2601,0.8328,0.5947,0.4626,0.3805,0.3230,0.2477,0.2027,0.1804];
    radialRaw = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0];
end 

%Find chord and pitch with spline fit from raw data with radial positions given by user  
chordvec = interp1(radialRaw,chordRaw,r1,'spline');
pitchvec = interp1(radialRaw,pitchRaw,r1,'spline');
end 










