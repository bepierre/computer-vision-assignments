function [mu, var, alpha] = maximization(P, X)

K = size(P,2);
N = size(X,1);

%initialization
alpha = zeros(1,K);
mu = zeros(K,3);
var = zeros(3,3,K);

%iterate
for k = 1:K
    alpha(k) = sum(P(:,k))/N;
    mu(k,:) = sum(X.*repmat(P(:,k),[1,3]))/(alpha(k)*N);
    for l = 1:N
        %mu(k,:) = mu(k,:) + (X(l,:)*P(l,k));
        var(:,:,k) = var(:,:,k) + P(l,k)*((X(l,:)-mu(k,:))'*(X(l,:)-mu(k,:)));
    end
    var(:,:,k) = var(:,:,k)/(alpha(k)*N);
end
alpha = alpha/sum(alpha);



end