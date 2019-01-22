%https://www.mathworks.com/matlabcentral/answers/83702-generate-random-coordinates-around-a-circle
function points = generateCirclePoints(centre, radius, n)
    
    x0=centre(1); % x0 an y0 center coordinates
    y0=centre(2);  
    points = zeros(2,n);
    
    angle=-pi:0.1:pi;
    angl=angle(randperm(numel(angle),n));
    
    points(1,:) = radius.*cos(angl)+x0;
    points(2,:) = radius.*sin(angl)+y0;