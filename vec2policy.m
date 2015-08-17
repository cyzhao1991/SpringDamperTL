function policy = vec2policy(policyVec)
    policy.theta.k = policyVec(1:end-1);
    policy.theta.sigma = policyVec(end);
    policy.backup = policy.theta;
end
 