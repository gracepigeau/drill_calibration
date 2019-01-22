
trial1 = DrillTipSimulator(100,80);
trial2 = DrillTipSimulator(100,50);
trial3 = DrillTipSimulator(100,20);

figure
hold on
scatter3(trial1(1,:),trial1(2,:),trial1(3,:), 'red')
%scatter3(trial2(1,:),trial2(2,:),trial2(3,:), 'blue')
%scatter3(trial3(1,:),trial3(2,:),trial3(3,:), 'black')
hold off

Tm = DrillTipCalibration(trial1)

