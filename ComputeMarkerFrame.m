%Compute Marker Frame
%CISC 330 - Computer Integrated Surgery
%Assignment 3 
%Grace Pigeau 10187678
%
%Purpose:   Define the marker coordinate system
%Input:     A B and C in tracker coordinates
%Output:    centre point (3x1 vector)
%           three base vectors (3x1 vectors)

function[Ctrm, Xm, Ym, Zm] = ComputeMarkerFrame(A,B,C)

    %Call function which creates an orthonormal coordinate system
    [Ctrm, Xm, Ym, Zm] = OrthonormalCoordinateSystem(A,B,C);