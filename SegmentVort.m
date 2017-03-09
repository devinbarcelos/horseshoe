function [ matQ ] = SegmentVort(valGAMMA, matP, matVOR1, matVOR2)
% This function calculates the induced velocity due to a vortex segment.
% This is done using Biot-Savart
%
% INPUTS
%   valGAMMA - Circulation of vortex segment
%   matP - A matrix of points of interest. Each row is associated to a POI
%   and the columns correspone to the x,y,z components of each points
%   matVOR1 - Location of left vortex segment end
%   matVOR2 - Location of right vortex segment end
%
% OUTPUTS
%   matQ - Induced velocity due to vortex segment at POI. Each row is
%   associated to each POI. Columns associated to u,v,w velocities


% Calcualte radius
matR1 = matVOR1 - matP; % Radius from point vortex seg end 1 to POI
matR2 = matVOR2 - matP; % Radius from point vortex seg end 2 to POI
matR0 = matR1-matR2; % Difference between radius


matR1xR2 = cross(matR1,matR2); % Cross product between raduis

% Calculate vector magnitudes
matR1MAG = sqrt(matR1(:,1).^2+matR1(:,2).^2+matR1(:,3).^2);
matR2MAG = sqrt(matR2(:,1).^2+matR2(:,2).^2+matR2(:,3).^2);
matR1xR2MAG = sqrt(matR1xR2(:,1).^2+matR1xR2(:,2).^2+matR1xR2(:,3).^2);


% Calcualte the induced velicty at each point of interest (matP)
matQ = (valGAMMA/(4*pi))*((matR1xR2)./((matR1xR2MAG).^2)).*(dot(matR0', ...
    ((matR1./matR1MAG)-(matR2./matR2MAG))'))';
end

