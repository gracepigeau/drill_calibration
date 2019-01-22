%Drill Tip Calibration Test
%CISC 330 - Computer Integrated Surgery 
%Assignment 3
%Grace Pigeau 10187678
%
%Purpose:   Test the accuracy of the drill tip calibration function

function DrillTipCalibration_test(truth)

trialCount = 1;
amntRight = 0;

%for range of 20, 40, 60, and 80 degrees
for ix = 20:20:80
    %for 20, 50, and 100 positions
    for jx = [20,50,100]
        %simulate a set of ABC marker points
        trial = DrillTipSimulator(jx, ix);
        
        %print info to console
        fprintf('Trial %i: %i degrees, %i positions',trialCount, ix, jx)
        %find the drill tip location in marker coordinates
        Tm = DrillTipCalibration_alt(trial)
        trialCount = trialCount+1;
        
        if (Tm == truth)
            amntRight = amntRight+1;
        end
    end
end

fprintf('%i/12 exactly matched the ground truth', amntRight)

