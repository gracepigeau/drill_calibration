%Drill Tip Calibration Alternate Method
%CISC 330 - Computer Integrated Surgery
%Assignment 3 
%Grace Pigeau 10187678
%
%Purpose:   Determine the drill tip location in marker coordinate system
%Input:     array of A,B,C markers in tracker coordinates
%Output:    Point in marker coordinates

function Tm = DrillTipCalibration_alt(markerPoints)

%Find the number of points in the input array
numPoints = size(markerPoints,2);
%Find the number of points provided for each marker
numPointsABC = numPoints/3;

%intialize two matrices to hold the rotation and translation matrices
R = zeros(3*numPointsABC,6);
t = zeros(3*numPointsABC,1);

%loop through every marker position
for ix = 1:3:numPoints
    Atemp = markerPoints(:,ix);
    Btemp = markerPoints(:,ix+1);
    Ctemp = markerPoints(:,ix+2);
    
    %find the orthonormal coordinate system defining the markers chosen
    %above
    [Ctrm, Am, Bm, Cm] = ComputeMarkerFrame(Atemp,Btemp,Ctemp);
    
    ti = Ctrm;
    
    Ri = [Am Bm Cm];

    R(ix:ix+2,1:3) = Ri;
    R(ix:ix+2,4:6) = [-1 0 0; 0 -1 0; 0 0 -1];
    
    t(ix:ix+2,:) = -1*ti;
end

%Find P which is a 6x1 vector containg Tm and Tt
P = pinv(R) * t;

Tm = P(1:3);

