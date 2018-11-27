function [in1, in2, out1, out2, m, F] = ransac8pF(xy1, xy2, threshold)
iter = 1000;
n = size(xy1,2);
N = 8;
bestInNum = 0;

xy1(3,:) = ones(1,n); 
xy2(3,:) = ones(1,n); 

p = 0.999;
m = inf;
i = 0;

while (i<m)
    i = i+1;
    index = randperm(n,N);
    x1s = xy1(:,index);
    x2s = xy2(:,index);
    [~,F_try] = fundamentalMatrix(x1s,x2s);
    costs = zeros(1,n);
    for j = 1:n
        costs(j) = distSampson(xy1(:,j), F_try, xy2(:,j));
    end
    
    % inliers
    in1_try =  xy1(1:2,find(costs <= threshold));
    in2_try =  xy2(1:2,find(costs <= threshold));
    % outliers
    out1_try =  xy1(1:2,find(costs > threshold));
    out2_try =  xy2(1:2,find(costs > threshold));
    
    if size(in1_try,2) > bestInNum
        bestInNum = size(in1_try,2);
        F = F_try;
        in1 = in1_try;
        in2 = in2_try;
        out1 = out1_try;
        out2 = out2_try;
        %update m
        r = bestInNum/n;
        m = nTrials(r,N,p);
    end
end
[~,F] = fundamentalMatrix([in1;ones(1,size(in1,2))],[in2;ones(1,size(in2,2))]);

end