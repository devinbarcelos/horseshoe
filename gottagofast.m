function [ matSEMIVORL, matSEMIVORR, matVORL, matVORR] = gottagofast(vecVORL,vecVORR, vecSEMIVORL,vecSEMIVORR, matP )
% This function is using for vectorizing input values
% VROOOM VROOOOOOMMM
% 
% INPUTS
%   vecVORL - left vorticity location (x,y,z)
%   vecVORR - right vorticity location (x,y,z)
%   vecSEMIVORL - location of left semivortex beginning (x,y,z)
%   vecSEMIVORR - location of right semivortex beginning (x,y,z)
%   matP - matrix of points of interest, used for size
%
% OUTPUTS
%   matVORL - repmat of vecVORL (size of number of POI)
%   matVORR - repmat of vecVORR (size of number of POI)
%   matSEMIVORL - repmat of vecSEMIVORL (size of number of POI)
%   matSEMIVORR - repmat of vecSEMIVORR (size of number of POI)

matSEMIVORL = repmat(vecSEMIVORL,[size(matP,1),1]);
matSEMIVORR = repmat(vecSEMIVORR,[size(matP,1),1]);

matVORL = repmat(vecVORL,[size(matP,1),1]);
matVORR = repmat(vecVORR,[size(matP,1),1]);

end

