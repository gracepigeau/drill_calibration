%Distance-of-Line-and-Point
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 1
%Grace Pigeau 10187678
%
%Purpose:   Calculate the distance between a line and a point
%Input:     line (two 3x1 vectors)
%           point (3x1 vector)
%Output:    distance (scalar)

function dist = DistanceOfLineAndPoint(point, linepoint1, linepoint2)
    
    %find the direction vector of the line
    linevector = linepoint1 - linepoint2;
    
    %find the vector formed between the point and one end of the line
    diffvector = point - linepoint2;
    
    %numerator: the length of the vector perpependicular to the
    %the two vectors calculated above
    %denominator: the length of the line vector
    dist = norm(cross(linevector, diffvector)) / norm(linevector); %final distance
    
    