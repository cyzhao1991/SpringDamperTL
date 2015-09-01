function action = generateAction(policy, state)
%% Written by Chenyang Zhao
% Generate action from current state and policy
% u = K[x; 1] + noise
% Reference: Jan Peters

%%
    action = mvnrnd(policy.theta.k*[state;1],policy.theta.sigma^2)';
end