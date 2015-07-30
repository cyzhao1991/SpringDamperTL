%% main funtion for single task SDM system

%% Initializaiton

k = 1;      %N/m
d = 0.01;   %N*s/m
m = 0.5;    %kg
sigma = [0.00001, 0.000001];
f = 100;    %Hz
initPos = 0;
desPos = 3;
Q = eye(1);
R = 0.01*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 20;

world = initWorld(k,d,m,sigma,f,initPos,desPos,Q,R,timeDiscount,maxIteration,maxTrail);

policyK = rand(1,3)*0;
policySigma = rand()*0.5;
policy = initGaussianPolicy(policyK,policySigma);

maxStep = 100;
learningRate = 0.05;
hisReward = [];
hisPolicy = [policy.theta.k,policy.theta.sigma];
hisPolicy2 = [];
%%

for i = 1:maxStep
    [dJdTheta, trailRewards] = thetaExplore(world, policy);
    updateGrad = mean(dJdTheta);
    policy.backup = policy.theta;
    policy.theta.k = policy.theta.k + learningRate*updateGrad(1:3);
    policy.theta.sigma = policy.theta.sigma + learningRate*updateGrad(end);
    policy.theta.sigma = max(policy.theta.sigma,0);
    
    trailRewards;
    hisReward =[hisReward mean(trailRewards)];
    hisReward(end)
    hisPolicy = [hisPolicy; [policy.theta.k,policy.theta.sigma]];
    hisPolicy2(i).policy = policy;
    if norm(policy.theta.k-policy.backup.k) < 0.0001
        break
    end
    i
end



