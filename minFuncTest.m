k = 1;      %N/m
d = 0.01;   %N*s/m
m = 0.5;    %kg
sigma = [0.00001, 0.000001];
f = 100;    %Hz
initPos = 0;
desPos = 2;
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

baseObj = @(theta)rewardFun(world,theta);
mfOptions.Method = 'newton';
a = minFunc(baseObj,rand(1,3),mfOptions);
