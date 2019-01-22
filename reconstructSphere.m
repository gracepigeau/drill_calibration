function [centreVector, radius] = reconstructSphere(data, n)

    %create A matrix
    dataT = data.';
    neg2dataT = (-2) * dataT;
    colOnes = ones(n,1);
    A = [neg2dataT colOnes];

    %create b vector
    b = zeros(n,1);
    for i = (1:n)
        colData = data(:,i);
        negcolData = (-1) * colData;
        dotCol = dot(negcolData,colData);
        b(i,1) = dotCol;
    end

    % c = A\b;
    % 
    % centreVector = c(1:3,:);
    % radius = c(4,:);

    %solve for x using QR decomposition
    [Q,R] = qr(A,0);
    y = (Q.') * b;
    x = backsub(R,y);
    
    centreVector = x(1:3,:);
    sigma = x(4,:);
    radius = sqrt(dot(centreVector,centreVector) - sigma);
    
    