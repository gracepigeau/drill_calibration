%Drill Axis Calibration Test
%CISC 330 - Computer Integrated Surgery 
%Assignment 3
%Grace Pigeau 10187678
%
%Purpose:   Test the accuracy of the drill axis calibration function

function DrillAxisCalibration_test(truth)

trialCount = 1;
amntRight = 0;

%for range of 30, 90, 180, and 360 degrees
for ix = [30, 90, 180, 360]
    %for 20, 50, and 100 positions
    for jx = [20,50,100]
        %simulate a set of ABC marker points
        trial = DrillAxisSimulator(jx, ix);
        
        %print info to console
        fprintf('Trial %i: %i degrees, %i positions',trialCount, ix, jx)
        %find the drill axis in marker coordinates
        Vm = DrillAxisCalibration(trial)
        trialCount = trialCount+1;
        
        if (Vm == truth)
            amntRight = amntRight+1;
        end
    end
end

fprintf('%i/12 exactly matched the ground truth', amntRight)
