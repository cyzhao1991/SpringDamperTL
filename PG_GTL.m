clearvars -except 'poolobj'
clc;
close all;



%% Initialization
dlist = [0.01,0.05,0.1,0.2,0.5];
klist = [1 2 3 4 5];
desPoslist = [1 2 3 4 5];
statevec = 'x,v,desPos';

m = 0.5;
sigma = [0.001 0.001];
f = 100;    %Hz
initPos = 0;
Q = diag([1,0.05]);
R = 0*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;
for i = 1:5
    worldlist(i) = initWorld(klist(i),dlist(1), m, sigma, f, initPos, desPoslist(1), Q, R,...
        timeDiscount, maxIteration, maxTrail,statevec);
end

if ~exist('policy','var')
    stateLength = length(strsplit(statevec,','));
    policyK = -1*ones(1,stateLength+1);
    policySigma = 0.3;
    policy = initGaussianPolicy(policyK,policySigma);
end

maxStep = 1000;
learningRate = 0.001;
hisReward = [];
iteraionReward = zeros(1,5);
hisPolicy = [policy.theta.k,policy.theta.sigma];
hisPolicy2 = [];
hisPolicy2(1).policy = policy;

%% 
if ~exist('poolobj','var')
    poolobj = parpool;
end
profile on;


for i = 1:maxStep
    for j = 1:5
        [dJdTheta, trailRewards] = thetaExplore(worldlist(j), policy);
        updateGrad = dJdTheta;
        policy.backup = policy.theta;
        policy.theta.k = policy.theta.k + learningRate*updateGrad(1:end-1);
        policy.theta.sigma = policy.theta.sigma + learningRate*updateGrad(end);
        policy.theta.sigma = max(policy.theta.sigma,0.01);

        iterationReward(j) = mean(trailRewards);
        hisPolicy = [hisPolicy; [policy.theta.k,policy.theta.sigma]];
        hisPolicy2(i+1).policy = policy;
        if norm(policy.theta.k-policy.backup.k) < 0.01
            break
        end
    end
    hisReward = [hisReward; iterationReward];
    hisReward(end,:)
    i
end