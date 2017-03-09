% ========================================================================
%                                 Horseshoe
%                       Devin Barcelos & Scott Lindsay
%                            AE8146 - Assignment 4                               
% ========================================================================

% This script calcualtes the induced velocities due to a single horseshoe
% vortex. The horseshoe is divide into a vortex segment (along the wing) 
% and two semi-infinite vorticies. The induced velocites is calcualted at 
% each point of interest using the Biot-Savart law.

% The script's structure is as follows:
%   - Accept all required aircraft inputs
%   - Adjust points of interest
%   - Calculate the circulation required to overcome the aircraft weight
%   - Run a vectorizing sequence
%   - Calculate the induced velocities from the vortex segment
%   - Calculate the induced velocities from semi-infinite vortex
%   - Calculate total induce velocity at each POI
%   - Plot the induced velocities calculate

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

% Points of interest: [x1,y1,z1;x2,y2,z2;..;xn,yn,xn]
matP = [valSPAN 0 0; 10 10.7143 1.0204;10 0.9184 10;10 0.9184 10]; 

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
