trial1 = DrillAxisSimulator(20,360);
%trial2 = DrillAxisSimulator(20,180);
%trial3 = DrillAxisSimulator(20,10);


figure
hold on
%scatter3(trial1(1,:),trial1(2,:),trial1(3,:), 'red')
%scatter3(trial2(1,:),trial2(2,:),trial2(3,:), 'blue')
%scatter3(trial3(1,:),trial3(2,:),trial3(3,:), 'black')
hold off

Vm = DrillAxisCalibration(trial1)