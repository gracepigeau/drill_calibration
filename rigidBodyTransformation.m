%Rigid-Body-Transform
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 8
%Grace Pigeau 10187678
%
%Purpose:   Determine the transformation applied to move a set of three
%           markers between two positions
%Input:     fiducial markers (six 3x1 vectors) 
%Output:    rotation (3x3 matrix)
%           transformation (3x1 vector)
%Citations:
%           Lines 10-27:
%           http://nghiaho.com/uploads/code/rigid_transform_3D.m

function [R,t] = rigidBodyTransformation(marker1a, marker2a, marker3a, marker1b, marker2b, marker3b)
    
    %create a matrix to hold each set of markers
    A = [marker1a.';marker2a.';marker3a.'];
    B = [marker1b.';marker2b.';marker3b.'];

    %find the centre point of both sets of markers
    centroid_A = mean(A);
    centroid_B = mean(B);

    N = size(A,1);

    H = (A - repmat(centroid_A, N, 1))' * (B - repmat(centroid_B, N, 1));

    [U,~,V] = svd(H);

    R = V*U';

    if det(R) < 0
        %printf('Reflection detected\n');
        V(:,3) = V(:,3)*(-1);
        R = V*U';
    end

    t = -R*centroid_A' + centroid_B';
    t = round(t, 10);
end