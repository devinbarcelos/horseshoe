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

valPOINTS = 25; % Number of points to calculate

% Points of interest: [x1,y1,z1;x2,y2,z2;..;xn,yn,xn]
[Y,Z] = meshgrid(linspace(-3*valSPAN/2,3*valSPAN/2,valPOINTS),linspace(-valSPAN,valSPAN,valPOINTS));
Y = reshape(Y,[valPOINTS^2,1]);
Z = reshape(Z,[1,valPOINTS^2])';
%matP = [valSPAN 0 0; 10 10.7143 1.0204;10 0.9184 10;10 0.9184 10]; 
matP = [repmat(valSPAN,[valPOINTS^2,1]),Y,Z];

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
% Quiver plot of induced velocities calculated
figure(1)
clf(1)
hold on
scale_factor = 2; % Adjust size of arrows
quiver(Y,Z,matQ(:,2).*scale_factor,matQ(:,3).*scale_factor, 'AutoScale','off')
axis equal
axis tight
title('Induced Velocities Downstream of Aircraft Wing')
xlabel('Span-wise distance (m)')
ylabel('z-direction (m)')
hold off

%% Find the downwash at the center span
valCENTER  = ceil(size(matQ, 1)./2);
s = sprintf('Downwash at center span: %.4f m/s in z-direction', matQ(valCENTER, 3));
disp(s);
