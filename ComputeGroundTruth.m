%Compute Ground Truth
%CISC 330 - Computer Integrated Surgery
%Assignment 3 
%Grace Pigeau 10187678
%
%Purpose:   Define the ground truth values for Ideal Drill Model
%Input:     Orthonormal coordinate system
%Output:    Drill tip and axis in marker coordinates

function [Tm, Vm] = ComputeGroundTruth(Ctrm, Xm, Ym, Zm)

    %values of ideal markers in tracker coordinates
    A = [5;0;20];
    B = [11;0;20];
    C = [5;0;26];
    
    %shift the points by the centre of the coordinate system
    Am = A - Ctrm;
    Bm = B - Ctrm;
    Cm = C - Ctrm;
    
    %find the rotation matrix and translation vector that
    %transforms tracker to marker coordinates
    [R, t] = rigidBodyTransformation(A,B,C,Am,Bm,Cm);
    
    %find the transformation matrix
    T = [R t];
    
    %get the drill tip by  multiplying the transformation matrix
    %by the drill tip in tracker coordinates 
    Tm = T*[0;0;0;1];
    
    %get rid of the padding to create a 3x1 point
    Tm = Tm(1:3,:);
    
    %get the drill axis by  multiplying the transformation matrix
    %by the z axis in tracker coordinates 
    V = T*[Zm;1];
    
    %find the vector between the drill tip and the z axis point
    Vm = V(1:3) - Tm;