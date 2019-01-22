function distance = DistBtwnPoints(point1, point2)
    distance = sqrt((point1(1,1) - point2(1,1))^2 + (point1(2,1) - point2(2,1))^2 + (point1(3,1) - point2(3,1))^2);