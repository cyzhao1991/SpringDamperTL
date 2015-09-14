

% PG_MTL

% clearvars -except 'poolobj' 
% load ('STL_k.mat','result');
% clc;
% close all;
% 
% 
% 
% % Initialization
% 
% if ~exist('poolobj','var')
%     poolobj = parpool;
% end
% profile on;
% %%
% dlist = [0.01,0.05,0.1,0.2,0.5];
% klist = [1 2 3 4 5];
% mlist = [0.5 1 2 3 5];
% desPoslist = [1 2 3 4 5];
% statevec = 'x,v';
% k = 3;
% T = length(desPoslist);
% 
% sigma = [0.001 0.001];
% f = 100;    %Hz
% initPos = 0;
% Q = diag([1,0.05]);
% R = 0*eye(1);
% timeDiscount = 0.999;
% maxIteration = 300;
% maxTrail = 100;
% learningrate = 0.001;
% for i = 1:T
%     worldlist(i) = initWorld(klist(i),dlist(1), mlist(1), sigma, f, initPos, desPoslist(4), Q, R,...
%         timeDiscount, maxIteration, maxTrail,statevec);
% end

stateLength = length(strsplit(statevec,','));
policyK = -1*ones(1,stateLength+1);
policySigma = 0.3;
initPolicy = initGaussianPolicy(policyK,policySigma);

%% STL for each task
for t = 1:T
    %policy{t} = singleTask(worldlist(t),initPolicy); 
    policy{t} = [result(t).policy.theta.k,result(t).policy.theta.sigma]';
    %makeAnimation(worldlist(t),vec2policy(policy{t}'));
end

W = cell2mat(policy);
[U,a,b] = svd(W);
tem = U*sqrt(a);
L = tem(:,1:k);

S = sqrt(a)*b';
S = S(1:k,:);
Z = zeros(2,T);
Z(1,:) = 1;
Z(2,:) = somelist;
S = S*pinv(Z);
%S = zeros(k,T);
%S(1,:) = 1;
%%
maxStep = 100;
SL = [reshape(S,[],1);reshape(L,[],1)];
for i = 1:maxStep
    SLOld = SL;
    for t = 1:T
        for j = 1:100
            curPolicy = vec2policy((L*S*Z(:,t))');
            [dJdTheta, trailRewards] = thetaExplore(worldlist(t), curPolicy);
            dJdS = (Z(:,t)*dJdTheta*L)' - 0.1*2*S;
            sOld = S;
            S = S+learningrate*dJdS
            if norm(sOld - S)<0.01
                break;
            end
            [~,~,tempreward] = makeAnimation(worldlist(t),curPolicy,false);
            tempreward
        end
    end
    
    i
    
    for j = 1:100
        dJdL = zeros(size(L));
        for t = 1:T
            curPolicy = vec2policy((L*S*Z(:,t))');
            [dJdTheta, trailRewards] = thetaExplore(worldlist(t), curPolicy);
            dJdL = dJdL + (S*Z(:,t)*dJdTheta)';
        end
        dJdL = dJdL/T - 0.1*2*L;
        lOld = L;
        L = L+learningrate*dJdL
        if norm(lOld-L)<0.01
            break;
        end
        [~,~,tempreward] = makeAnimation(worldlist(t),curPolicy,false);
        tempreward
    end
    i
    SL = [reshape(S,[],1);reshape(L,[],1)];
    
    if norm(SL-SLOld)<0.05
        break;
    end
end





