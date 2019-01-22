function [point, normal] = getPlane(data, n)

    %get the mean of the data
    sum = zeros(3,1);
    for i = (1:n)
        sum = sum + data(:,i);
    end
    point = sum ./ n;
    
    Zj = zeros(3,n);

    %get all zj values
    for i = (1:n)
         newCol = (data(:,i) - point);
         Zj(:,i) = newCol;
    end
    
    %create Z
    Z = zeros(3,3);
    for i = (1:n)
        ZjT = (Zj(:,i)).';
        Z = Z + (Zj(:,i) * ZjT);
    end
    
    %find eigenvalues and vectors of Z
    [eigvecZ, eigvalZ] = eig(Z);
    %mineigval = Min(eigvalZ)
     
    eigVal1 = eigvalZ(1,1);
    eigVal2 = eigvalZ(2,2);
    eigVal3 = eigvalZ(3,3);
    
    %find smallest eigenvalue in Z
    if eigVal1 < eigVal2 && eigVal1 < eigVal2
        minEigVal = eigVal1;
    elseif eigVal2 < eigVal3
        minEigVal = eigVal2;
    else
        minEigVal = eigVal3;
    end
    
    %find corresponsing eigenvector
    if minEigVal == eigVal1
        lambda3 = eigvecZ(:,1);
    elseif minEigVal == eigVal1
        lambda3 = eigvecZ(:,2);
    else
        lambda3 = eigvecZ(:,3);
    end 
   
    %E = lambda3.' * Z * lambda3
    
    normal = lambda3/norm(lambda3);
    
   