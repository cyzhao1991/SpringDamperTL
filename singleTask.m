function learnedPolicy = singleTask(world,policy,maxStep,varargin)

if nargin < 3
    maxStep = 500;
end
learningRate = 0.001;
for i = 1:maxStep
    [dJdTheta, trailRewards] = thetaExplore(world, policy);
    updateGrad = dJdTheta;
    policy.backup = policy.theta;
    policy.theta.k = policy.theta.k + learningRate*updateGrad(1:end-1);
    policy.theta.sigma = policy.theta.sigma + learningRate*updateGrad(end);
    policy.theta.sigma = max(policy.theta.sigma,0.01);
    if norm(policy.theta.k-policy.backup.k) < 0.01
        break
    end
end
learnedPolicy = [policy.theta.k,policy.theta.sigma]';
end