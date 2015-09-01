%% main funtion for single task SDM system

%% Initializaiton
if ~exist('k','var')
    k = 1;      %N/m
end

if ~exist('d','var')
    d = 0.01;   %N*s/m
end

if ~exist('m','var')
    m = 0.5;    %kg
end

if ~exist('desPos','var')
    desPos = 4;
end

sigma = [0.001 0.001];
f = 100;    %Hz
initPos = 0;
Q = diag([1,0.05]);
R = 0*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;

if ~exist('statevec','var')
    statevec = 'x,v,desPos';
end

world = initWorld(k,d,m,sigma,f,initPos,desPos,Q,R,timeDiscount,maxIteration,maxTrail,statevec);


%policyK = rand(1,3)*0;
if ~exist('policy','var')
    stateLength = length(strsplit(statevec,','));
    policyK = -1*ones(1,stateLength+1);
    policySigma = 0.3;
    policy = initGaussianPolicy(policyK,policySigma);
end

maxStep = 1000;
learningRate = 0.001;
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
    policy.theta.k = policy.theta.k + learningRate*updateGrad(1:end-1);
    policy.theta.sigma = policy.theta.sigma + learningRate*updateGrad(end);
    policy.theta.sigma = max(policy.theta.sigma,0.01);
    
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



