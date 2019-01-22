%Drill Axis Simulator
%CISC 330 - Computer Integrated Surgery 
%Assignment 3
%Grace Pigeau 10187678
%
%Purpose:   Simulate the spinning of a drill
%Input:     the number of calibration poses (n), the range of the angle
%Output:    matrix of marker points

function markerPoints = DrillAxisSimulator(n, range) 

% %GRAPH:
% figure
% hold on
% str = sprintf('Drill Axis Simulator: %i degrees, %i positions', range, n);
% title(str)
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% hold on

%initialize a matrix to hold the generated markerpoints
markerPoints = zeros(3,n*3);
    
%set the value of the markers in tracker coordinates
A = [5;0;20];
B = [11;0;20];
C = [5;0;26];

%define a line along the z axis
linePoint1 = [0;0;0];
linePoint2 = [0;0;1];

%find the distance from each point to the above line
radiusA = DistanceOfLineAndPoint(A, linePoint1, linePoint2);
radiusB = DistanceOfLineAndPoint(B, linePoint1, linePoint2);
radiusC = DistanceOfLineAndPoint(C, linePoint1, linePoint2);

%initialize three matrices to hold the points for each marker
pointsA = zeros(3,n);
pointsB = zeros(3,n);
pointsC = zeros(3,n);

%create a while loop which runs until n points have been generated
for ix = 1:n

    %set the maximum and minimum values for the azimuth angle
    azmin = 0;
    azmax = range; %ensures angle constraint
    %randomly generate an azimuth angle
    newazangle = (azmax-azmin).*rand + azmin;

    %set the maximum and minimum values for the polar angle
    %setting these both to 0 creates a circle instead of a sphere
    pmin = 0;
    pmax = 0;
    %randomly generate a polar angle
    newpolarangle = (pmax-pmin).*rand + pmin;

    %calculate the components of three random points by transforming 
    %the spherical coordinates (angles) to cartesian coordinates
    xA = radiusA .* cosd(newpolarangle) .* cosd(newazangle);
    yA = radiusA .* cosd(newpolarangle) .* sind(newazangle);
    zA = radiusA .* sind(newpolarangle);
    xB = radiusB .* cosd(newpolarangle) .* cosd(newazangle);
    yB = radiusB .* cosd(newpolarangle) .* sind(newazangle);
    zB = radiusB .* sind(newpolarangle);
    xC = radiusC .* cosd(newpolarangle) .* cosd(newazangle);
    yC = radiusC .* cosd(newpolarangle) .* sind(newazangle);
    zC = radiusC .* sind(newpolarangle);

    %combine x, y, and z to create the three new points
    randpointA = [xA;yA;zA];
    randpointB = [xB;yB;zB];
    randpointC = [xC;yC;zC];

    %add the random points to the point matrices
    pointsA(:,ix) = randpointA;
    pointsB(:,ix) = randpointB;
    pointsC(:,ix) = randpointC;
    

end %end while

%create three  1d matrices which each contain the z value of the
%corresponding marker
tempA = ones(1,n)*A(3);
tempB = ones(1,n)*B(3);
tempC = ones(1,n)*C(3);

%set the z value of each point matrix so it is the appropriate heightw
pointsA = [pointsA(1:2,:) ; tempA];
pointsB = [pointsB(1:2,:) ; tempB];
pointsC = [pointsC(1:2,:) ; tempC];

% %GRAPH:
% hold on
% scatter3(pointsA(1,:), pointsA(2,:), pointsA(3,:),'red')
% scatter3(pointsB(1,:), pointsB(2,:), pointsB(3,:),'blue')
% scatter3(pointsC(1,:), pointsC(2,:), pointsC(3,:), 'green')
% hold off

%combine points from spheres in form ABCABC....
jx = 1;
for ix = 1:n
    markerPoints(:,jx) = pointsA(:,ix);
    jx = jx+1;
    markerPoints(:,jx) = pointsB(:,ix);
    jx = jx+1;
    markerPoints(:,jx) = pointsC(:,ix);
    jx = jx+1;
end



