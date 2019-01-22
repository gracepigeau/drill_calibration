function randpoints = generateSpherePoints(ctr, radius, n, maxoff)

    %generate an array of zeros to hold the points around the sphere
    randpoints = zeros(3,n);
    %generate an array of zeros to hold the distances from the points to
    %the sphere
    errors = zeros(1,n);
    
    %create a while loop which runs until n points have been generated
    for ix = 1:n
        
        %set the maximum and minimum values for the radius
        rmin = radius - maxoff;
        rmax = radius + maxoff;
        %randomly generate a new radius within the max and min confines
        newradius = (rmax-rmin).*rand + rmin;
        
        %set the maximum and minimum values for the azimuth angle
        azmin = -180;
        azmax = 180;
        %randomly generate an azimuth angle
        newazangle = (azmax-azmin).*rand + azmin;
        
        %set the maximum and minimum values for the polar angle
        pmin = -90;
        pmax = 90;
        %randomly generate a polar angle
        newpolarangle = (pmax-pmin).*rand + pmin;
        
        %calculate the components of a random point by transforming 
        %the spherical coordinates (angles) to cartesian coordinates
        x = newradius .* cosd(newpolarangle) .* cosd(newazangle);
        y = newradius .* cosd(newpolarangle) .* sind(newazangle);
        z = newradius .* sind(newpolarangle);
        
        %combine x, y, and z to create the new point
        randpoint = [x;y;z];
        
        %transform the point generated so it is on the surface of the
        %sphere by adding the centre point
        randpoint = randpoint + ctr;
        
        %add the random points to the point matrix
        randpoints(:,ix) = randpoint;
        
    end %end while
    