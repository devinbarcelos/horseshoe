% Horseshoe - Written by Devin Barcelos & Scott Lindsay
clear,clc
%% Inputs
% General Aircraft Information
valMASS = 200; % Mass of aircraft (kg)
valSPAN = 10; % Aircraft span (m)
valUINF = 50; % Freestream velocity (m/s)
valDENSITY = 1.225; % Density (kg/m^3)

% Vortex Locations
vecVORL = [0 -valSPAN/2 0];
vecVORR = [0 valSPAN/2 0];
vecSEMIVORR = [0 valSPAN/2 0];
vecSEMIVORL = [0 -valSPAN/2 0];

% Points of interest
matP = [valSPAN 0 0; 10 10.7143 1.0204;10 0.9184 10;10 0.9184 10]; % Points of interest

%% Begin Vortex Lattice method calculations
% Calculate circulation from lift (from aircraft weight)
valGAMMA = (valMASS*9.81)/(valDENSITY*valUINF*valSPAN);

% Run vectorizing function
[matSEMIVORL, matSEMIVORR, matVORL, matVORR] = gottagofast(vecVORL, ...
    vecVORR, vecSEMIVORL,vecSEMIVORR, matP );

% Calculate induced velocities due to vortex segment
[matQS] = SegmentVort(valGAMMA, matP, matVORL, matVORR);

% Calcualte induced velocities due to semi-infinite vortex
[matQL] = SemiVortex(valGAMMA, matP, matSEMIVORR); % Left vortex
[matQR] = SemiVortex(-valGAMMA, matP, matSEMIVORL); % Right vortex

% Calculate total induced velocity
matQ = matQL + matQR + matQS;

%% Plot The Induced Velocity Distribution
