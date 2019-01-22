%Drill Axis Calibration
%CISC 330 - Computer Integrated Surgery
%Assignment 3 
%Grace Pigeau 10187678
%
%Purpose:   Determine the drill axis direction in marker coordinate system
%Input:     array of A,B,C markers in tracker coordinates
%Output:    Vector in marker coordinates

function Vm = DrillAxisCalibration(markerPoints)

%Find the number of points in the input array
numPoints = size(markerPoints,2);
%Find the number of points provided for each marker
numPointsABC = numPoints/3;

%Initialize the matrices which will hold the markers
markerPointsA = zeros(3, numPointsABC);
markerPointsB = zeros(3, numPointsABC);
markerPointsC = zeros(3, numPointsABC);

%add all the markerA points to the matrix
trackA = 1;
for ix = 1:3:numPoints
    markerPointsA(:,trackA) = markerPoints(:,ix);
    trackA = trackA + 1;
end

%add all the markerB points to the matrix
trackB = 1;
for ix = 1:3:numPoints
    markerPointsB(:,trackB) = markerPoints(:,ix);
    trackB = trackB + 1;
end

%add all the markerC points to the matrix
trackC = 1;
for ix = 1:3:numPoints
    markerPointsC(:,trackC) = markerPoints(:,ix);
    trackC = trackC + 1;
end

%Find the normal of each circle
[~, normalA] = getPlane(markerPointsA, numPointsABC);
[~, normalB] = getPlane(markerPointsB, numPointsABC);
[~, normalC] = getPlane(markerPointsC, numPointsABC);

%ensure the normals are all facing the same direction
normalA = [normalA(1:2) ; abs(normalA(3))];
normalB = [normalB(1:2) ; abs(normalB(3))];
normalC = [normalC(1:2) ; abs(normalC(3))];

%average the normals to find the drill axis in tracker coorinates
normal = mean([normalA normalB normalC],2);
Vt = round(normal, 10);

%initialize a matrix to hold the rotated axes
Vms = zeros(3,numPointsABC);
%keep track of where you are in Vms
vtracker = 1;

%loop through all marker points
for ix = 1:3:numPoints
    
    %get the  ABC marker points at position ix
    Atemp = markerPoints(:,ix);
    Btemp = markerPoints(:,ix+1);
    Ctemp = markerPoints(:,ix+2);
    
    %find the orthogonal coordinate system which defines the marker points
    [Ctrm, Am, Bm, Cm] = ComputeMarkerFrame(Atemp,Btemp,Ctemp);
    
    %create the rotation matrix from the above system to tracker coordinates
    Ri = [Am Bm Cm];
    
    %add the rotated drill axis to Vms
    Vms(:,vtracker) = Ri*Vt;
    vtracker = vtracker + 1;
end

%find the drill axis in marker coordinates
%this is the average of the rotated values
Vm = mean(Vms,2);
