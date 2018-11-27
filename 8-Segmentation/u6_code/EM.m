function [map, cluster] = EM(img)
    %convert img to double
    img = double(img);
    
    %number of clusters
    K = 4;
    
    %create x
    [m, n, ~] = size(img);
    L = m*n;
    img_L = img(:,:,1);
    img_a = img(:,:,2);
    img_b = img(:,:,3);
    X = [img_L(:)'; img_a(:)'; img_b(:)'; ones(1,L)];
    
    %normalize points
    [Xn, T] = normalise3dpts(X);
    Xn = Xn(1:3,:)';
    
    %get some values
    Lmax = max(Xn(:,1)); Lmin = min(Xn(:,1));
    amax = max(Xn(:,2)); amin = min(Xn(:,2));
    bmax = max(Xn(:,3)); bmin = min(Xn(:,3));
    
    % use function generate_mu to initialize mus
    mu_s = generate_mu(Lmax,Lmin,amax,amin,bmax,bmin,K);
    
    % use function generate_cov to initialize covariances
    var_s = generate_cov(Lmax,Lmin,amax,amin,bmax,bmin,K);
    
    %alphas
    alpha_s = 1/K * ones(1,K);
    
    tol = 0.3;
    deltaP = tol+1;
    
    % iterate between maximization and expectation
    while deltaP > tol
        % use function maximization
        P = expectation(mu_s,var_s,alpha_s,Xn);
        % use function expectation
        [mu_sp1, var_sp1, alpha_sp1] = maximization(P,Xn);
        %deltaP = norm(mu_s(:)-mu_sp1(:))+norm(var_s(:)-var_sp1(:))+norm(alpha_s(:)-alpha_sp1(:));
        deltaP = norm(mu_s(:)-mu_sp1(:));
        mu_s = mu_sp1; var_s = var_sp1; alpha_s = alpha_sp1;
        %visualizeMostLikeySegments(img, alpha_s, mu_s, var_s);
    end
    [~,ind] = max(P,[],2);
    map = reshape(ind, [m,n]);
    cluster = mu_sp1;
    clusterh = [cluster'; ones(1,size(cluster,1))];
    clusterun = T\clusterh;
    cluster = clusterun(1:3,:)';
    
    % show results
    cluster_peaks = cluster
    normalized_covariance_matrices = var_s
    weights = alpha_s
end