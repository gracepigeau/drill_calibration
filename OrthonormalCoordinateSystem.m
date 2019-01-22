%Orthonormal-Coordinate-System
%CISC 330 - Computer Integrated Surgery 
%Assignment 1 Question 7
%Grace Pigeau 10187678
%
%Purpose:   Create an Ortho-Normal vector base from 3 points
%Input:     three points (3x1 vectors)
%Output:    centre point (3x1 vector)
%           three base vectors (3x1 vectors)

function [centre, base1, base2, base3] = OrthonormalCoordinateSystem(point1, point2, point3)
    
    %find cross product to create three orthogonal vectors while keeping
    %the right hand rule
    x = point2 - point1;
    y = cross(x,(point1-point3));
    z = cross(x, y);
    
    %normalize x,y,z to make them unit length
    base1 = x/norm(x);
    base2 = y/norm(y);
    base3 = z/norm(z);
    
    %find the centre of gravity by averaging the three points
    centre = (point1 + point2 + point3) / 3;
 
    