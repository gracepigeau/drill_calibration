%Drill Tip Calibration Robustness Test
%CISC 330 - Computer Integrated Surgery 
%Assignment 3
%Grace Pigeau 10187678
%
%Purpose:   Test the robustness of the drill tip calibration function

function DrillTipCalibrationRobustness_test(truth)

%initialize a matrix to hold the Emax values and the error they creat
differences = zeros(2, 21);

diffCount = 1;
foundCutOff = 0;

for ix = 0:0.1:2
    %generate 300 points with a range of 80 degrees
    trial = DrillTipSimulator(100, 80);
    
    %loop through all positions
    for jx = 1:100
    
        %randomly generate an x,y, and z error amount <= ix
        newx = (ix).*rand;
        newy = (ix).*rand;
        newz = (ix).*rand;
        %add these error values to a vector
        newShift = [newx;newy;newz];
        
        %add this vector to each marker at position jx
        trial(:,jx) = trial(:,jx) + newShift;
        trial(:,jx+1) = trial(:,jx+1) + newShift;
        trial(:,jx+2) = trial(:,jx+2) + newShift;
    end %end if
    
    %calculate the drill tip from the markerpoints with error added
    Tm = DrillTipCalibration(trial);
    differences(1,diffCount) = ix;
    differences(2,diffCount) = DistBtwnPoints(Tm,truth);
    
    %record the first Emax where the difference between 
    %the calculated tip and the ground truth
    if (DistBtwnPoints(Tm,truth) > 0.1 && foundCutOff == 0)
        Emax = ix
        foundCutOff = 1;
    end
    
    diffCount = diffCount + 1;
end

%graph the errors
figure
hold on
title('Drill Tip Robustness Test')
xlabel('Emax (cm)')
ylabel('Calibration Error (cm)')
plot(differences(1,:), differences(2,:), 'black')
plot([0 2], [.1 .1], 'red')
hold off