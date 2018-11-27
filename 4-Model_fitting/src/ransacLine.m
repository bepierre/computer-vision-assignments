function [k, b] = ransacLine(data, dim, iter, threshDist, inlierRatio)
% data: a 2xn dataset with #n data points
% num: the minimum number of points. For line fitting problem, num=2
% iter: the number of iterations
% threshDist: the threshold of the distances between points and the fitting line
% inlierRatio: the threshold of the number of inliers

number = size(data,2); % Total number of points
bestInNum = 0;         % Best fitting line with largest number of inliers
k=0; b=0;              % parameters for best fitting line

distanceP2L = @(x0,y0,a,b,c) abs(a*x0 + b*y0 + c)/sqrt(a^2 + b^2);

for i=1:iter
    % Randomly select 2 points
    i = randi(number);
    j = randi(number);
    while j==i
        j = randi(number);
    end
    % Compute the distances between all points with the fitting line
    k_try = (data(2,j) - data(2,i)) / (data(1,j) - data(1,i));
    b_try = data(2,i) - k_try * data(1,i); 
    distances = distanceP2L(data(1,:),data(2,:),-k_try,1,-b_try);

    % Compute the inliers with distances smaller than the threshold
    inliers = data(:,find(distances <= threshDist));
    
    % Update the number of inliers and fitting model if better model is found
    if size(inliers,2) > bestInNum && size(inliers,2)/number > inlierRatio
        bestInNum = size(inliers,2);
        k = k_try;
        b = b_try;
        best_inliers = inliers;
    end
end
coef = polyfit(best_inliers(1,:), best_inliers(2,:), 1);
k = coef(1);
b = coef(2);
end
