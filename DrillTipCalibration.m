%Drill Tip Calibration
%CISC 330 - Computer Integrated Surgery
%Assignment 3 
%Grace Pigeau 10187678
%
%Purpose:   Determine the drill tip location in marker coordinate system
%Input:     array of A,B,C markers in tracker coordinates
%Output:    Point in marker coordinates

function Tm = DrillTipCalibration(markerPoints)

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

%find the centre point of the sphere which can be reconstructed from the
%marker points
centreAt = reconstructSphere(markerPointsA, numPointsABC);
centreBt = reconstructSphere(markerPointsB, numPointsABC);
centreCt = reconstructSphere(markerPointsC, numPointsABC);

%find the average of the centre points
%this if the drill tip in tracker coordinates
Tt = mean([centreAt centreBt centreCt],2);

%create an array to hold the Pcal values for each position
pivotPoints = zeros(3,numPointsABC);
%keep track of where you are in pivotPoints
pivotTracker = 1;

%loop through all marker points
for ix = 1:3:numPoints
    
    %get the  ABC marker points at position ix
    Atemp = markerPoints(:,ix);
    Btemp = markerPoints(:,ix+1);
    Ctemp = markerPoints(:,ix+2);
    
    %find the orthogonal coordinate system which defines the marker points
    [Ctrm, Am, Bm, Cm] = ComputeMarkerFrame(Atemp,Btemp,Ctemp);
    
    %create the rotation matrix from the above system to tracker coordinates
    R = [Am Bm Cm];
    %create the translation vector from the above system to tracker coordinates
    t = Ctrm;
    
    %Create the Pcal vector which is in marker coordinates
    Pcal = inv(R) * (Tt-t);

    %add Pcal to the pivot point matrix
    pivotPoints(:,pivotTracker) = Pcal;
    pivotTracker = pivotTracker + 1;
end

%find the drill tip in marker coordinates
%this is the average of all Pcal values
tempTm = mean(pivotPoints,2);
Tm = round(tempTm, 10);
