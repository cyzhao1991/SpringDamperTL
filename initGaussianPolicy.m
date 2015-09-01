function policy = initGaussianPolicy(k,sigma)
%% Written by Chenyang Zhao
% policy = initGaussianPolicy returns the initial gaussian policy,
% where sigma is the co-variance matrix.
%%
policy = struct();
policy.theta.k = k;
policy.theta.sigma = sigma;
policy.backup = policy.theta;

end