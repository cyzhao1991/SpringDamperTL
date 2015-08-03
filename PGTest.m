%% main funtion for single task SDM system

%% Initializaiton

k = 1;      %N/m
d = 0.01;   %N*s/m
m = 0.5;    %kg
sigma = [0.00001, 0.000001];
f = 100;    %Hz
initPos = 0;

if ~exist('desPos','var')
    desPos = 4;
end

Q = eye(1);
R = 0.01*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;

world = initWorld(k,d,m,sigma,f,initPos,desPos,Q,R,timeDiscount,maxIteration,maxTrail);

policyK = rand(1,3)*10-5;
policySigma = 0.3;
policy = initGaussianPolicy(policyK,policySigma);

maxStep = 100;
learningRate = 0.02*0.05;
hisReward = [];
hisPolicy = [policy.theta.k,policy.theta.sigma];
hisPolicy2 = [];
hisPolicy2(1).policy = policy;

% if ~exist('poolobj','var')
%     poolobj = parpool;
% end
%%

%profile on;

for i = 1:maxStep
    [dJdTheta, trailRewards] = thetaExplore(world, policy);
    updateGrad = dJdTheta;
    policy.backup = policy.theta;
    policy.theta.k = policy.theta.k + learningRate*updateGrad(1:3);
    policy.theta.sigma = policy.theta.sigma + learningRate*updateGrad(end);
    policy.theta.sigma = max(policy.theta.sigma,0.01);
    
    trailRewards;
    hisReward =[hisReward mean(trailRewards)];
    hisReward(end)
    hisPolicy = [hisPolicy; [policy.theta.k,policy.theta.sigma]];
    hisPolicy2(i+1).policy = policy;
    if norm(policy.theta.k-policy.backup.k) < 0.01
        break
    end
    i
end

% delete(poolobj);

%profile off
%profile viewer



