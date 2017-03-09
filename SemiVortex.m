function [matQ] = SemiVortex(valGAMMA, matP, matSEMIVOR)
% This function calculated the induced velocity from a semi-infinite
% vortex. This is done using Biot-Savart. The semi-infinite vortex is
% broken into one semi-infinite vortex perpendicular to the POI and one
% vortex segment. These two induced velocities are calculated and summed.
%
% INPUTS
%   valGAMMA - Circulation
%   matP - Matrix of points of interest. 3 columns associated to x,y,z and
%   each row associated to a point of interest
%   matSEMIVOR - Location of start of semi-infinite vortex
%
% OUTPUTS
%   matQ - Matrix of induced velocities 


% Calculate required vectors
matD = (matSEMIVOR-matP); % Vector from POI to semi-infinite vortex end
% Calcualte shorted distance from POI to semi-infite vortex
matDMAG = sqrt((matD(:,2).^2)+(matD(:,3).^2)); 
% Vector from vortex end to perpendicular component
matSEMIINFVEC = [matP(:,1) matSEMIVOR(:,2) matSEMIVOR(:,3)]-matSEMIVOR;

% Calcualte the direction of the induced velocity from semi-infinite vortex
matDIR = cross(matD,matSEMIINFVEC); % Done by nomarlizing the cross product
matDIR = matDIR./(sqrt(matDIR(:,1).^2 + matDIR(:,2).^2 + matDIR(:,3).^2));

% Calculate the end points of the vortex segmnet
matVOR2 = [matP(:,1) matSEMIVOR(:,2) matSEMIVOR(:,3)];

% Calcualte induced velocities due to vortex segment
[matQSEG] = SegmentVort(valGAMMA, matP, matSEMIVOR, matVOR2);

% Calcualte induced velocities due to the semi-infinite vortex (special
% case solution)
vecQSEMI = (valGAMMA./(4*pi*matDMAG));

% Calculate induced velocities due to entire semi-infinte vortex
matQ = matDIR.*vecQSEMI + matQSEG;

end

