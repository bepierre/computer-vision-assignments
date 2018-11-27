function peak = find_peak(X, xl, r)
   %find the pixels within the sphere of xenter xl and radius r
    L = size(X,2);
    peak = xl;
    tol = 10;
    diff = tol + 1;
    while diff > tol
        dists = sqrt(sum(((X - repmat(peak, [1,L])).^2)));
        sphere = X(:,dists<r);
        centerMass = mean(sphere,2);
        diff = norm(peak-centerMass);
        peak = centerMass;
    end
end
