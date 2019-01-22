A = [5;0;20];
B = [11;0;20];
C = [5;0;26];

[Ctrm, Xm, Ym, Zm] = ComputeMarkerFrame(A,B,C)

[Tm, Vm] = ComputeGroundTruth(Ctrm, Xm, Ym, Zm)