%Drill Tip Simulator
%CISC 330 - Computer Integrated Surgery 
%Assignment 3
%Grace Pigeau 10187678
%
%Purpose:   Simulate the rotation of a drill around a point
%Input:     the number of calibration poses (n), the range of the angle
%Output:    matrix of marker points

function markerPoints = DrillTipSimulator(n, range)

%     %GRAPH:
%     figure
%     str = sprintf('Drill Tip Simulator: %i degrees, %i positions', range, n);
%     title(str)
%     xlabel('X')
%     ylabel('Y')
%     zlabel('Z')
    
    %initialize a matrix to hold the generated markerpoints
    markerPoints = zeros(3,n*3);
    
    %set the value of the markers in tracker coordinates
    A = [5;0;20];
    B = [11;0;20];
    C = [5;0;26];
    
    %set the distance from the drill tip to markers A and C 
    radiusA = 20;%DistBtwnPoints(A, [0;0;0])
    radiusC = radiusA+6;
    
    %initialize three matrices to hold the points for each marker
    pointsA = zeros(3,n);
    pointsB = zeros(3,n);
    pointsC = zeros(3,n);
    
    %create a while loop which runs until n points have been generated
    for ix = 1:n
        
        %set the maximum and minimum values for the azimuth angle
        azmin = -180;
        azmax = 180;
        %randomly generate an azimuth angle
        newazangle = (azmax-azmin).*rand + azmin;
        
        %set the maximum and minimum values for the polar angle
        pmin = 90-range; %this ensures it is within specified constraint
        pmax = 90;
        %randomly generate a polar angle
        newpolarangle = (pmax-pmin).*rand + pmin;

        %calculate the components of points A and C by transforming 
        %the spherical coordinates (angles) to cartesian coordinates
        xA = radiusA .* cosd(newpolarangle) .* cosd(newazangle);
        yA = radiusA .* cosd(newpolarangle) .* sind(newazangle);
        zA = radiusA .* sind(newpolarangle);
        xC = radiusC .* cosd(newpolarangle) .* cosd(newazangle);
        yC = radiusC .* cosd(newpolarangle) .* sind(newazangle);
        zC = radiusC .* sind(newpolarangle);
        
        %combine x, y, and z to create A and C points
        randpointA = [xA;yA;zA];
        randpointC = [xC;yC;zC];
        
        %find a direction vector that is perpendicular to the z-axis
        %and the line between A and C markers
        dirB = cross((randpointA-randpointC), [0;0;1]);
        dirB = dirB / norm(dirB);
        
        %shift each point a set amount in the direction of the 
        %vector calculated above
        randpointA = randpointA + 5*dirB;
        randpointC = randpointC + 5*dirB;
        randpointB = randpointA + 6*dirB;
        
        %add the random points to the point matrices
        pointsA(:,ix) = randpointA;
        pointsB(:,ix) = randpointB;
        pointsC(:,ix) = randpointC;
%         
%         %Testing:
%         distAB = DistBtwnPoints(randpointA, randpointB);
%         distAC = DistBtwnPoints(randpointA, randpointC);
%         distBC = DistBtwnPoints(randpointC, randpointB);
%         
%         %GRAPH:
%         hold on
%         %plot3([randpointA(1) randpointB(1) randpointC(1)], [randpointA(2) randpointB(2) randpointC(2)],[randpointA(3) randpointB(3) randpointC(3)], 'black')
%         scatter3(randpointA(1), randpointA(2), randpointA(3),'red')
%         scatter3(randpointB(1), randpointB(2), randpointB(3),'blue')
%         scatter3(randpointC(1), randpointC(2), randpointC(3), 'green')
%         hold on
    end %end while
%hold off

    
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
    
    