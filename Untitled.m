

%% PG_MTL
clearvars -except 'poolobj'
clc;
close all;



%% Initialization

if ~exist('poolobj','var')
    poolobj = parpool;
end
profile on;

dlist = [0.01,0.05,0.1,0.2,0.5];
klist = [1 2 3 4 5];
desPoslist = [1 2 3 4 5];
statevec = 'x,v,k,d,desPos';
k = 3;
T = length(klist);

m = 0.5;
sigma = [0.001 0.001];
f = 100;    %Hz
initPos = 0;
Q = diag([1,0.05]);
R = 0*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;
learningrate = 0.001;
for i = 1:5
    worldlist(i) = initWorld(klist(1),dlist(1), m, sigma, f, initPos, desPoslist(i), Q, R,...
        timeDiscount, maxIteration, maxTrail,statevec);
end

stateLength = length(strsplit(statevec,','));
policyK = -1*ones(1,stateLength+1);
policySigma = 0.3;
initPolicy = initGaussianPolicy(policyK,policySigma);

%% STL for each task
for t = 1:T
    policy{t} = singleTask(worldlist(t),initPolicy);
    makeAnimation(worldlist(t),vec2policy(policy{t}'));
    t
end

policy
W = cell2mat(policy);
[U,~,~] = svd(W);
L = U(:,1:k);

S = ones(k,T);
S(1,:) = 1;

%%
maxStep = 100;

for i = 1:maxStep
    
    for t = 1:T
        for j = 1:300
            curPolicy = vec2policy((L*S(:,t))');
            [dJdTheta, trailRewards] = thetaExplore(worldlist(t), curPolicy);
            dJdS = (dJdTheta*L)' - 0.1*2*S(:,t);
            sOld = S(:,t);
            S(:,t) = S(:,t)+learningrate*dJdS
            if norm(sOld - S(:,t))<0.01
                break;
            end
        end
    end
    
    i
    
    for j = 1:300
        dJdL = zeros(size(L));
        for t = 1:T
            curPolicy = vec2policy((L*S(:,t))');
            [dJdTheta, trailRewards] = thetaExplore(worldlist(t), curPolicy);
            dJdL = dJdL + (S(:,t)*dJdTheta)';
        end
        dJdL = dJdL/T - 0.1*2*L;
        lOld = L;
        L = L+learningrate*dJdL
        if norm(lOld-L)<0.01
            break;
        end
    end
    
    i
    
end





