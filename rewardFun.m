function accReward = rewardFun(world, theta)
%% Written by Chenyang Zhao

%%
policy.theta.k = theta;
policy.theta.sigma = 0;
policy.backup = policy.theta;
accReward = 0;
accDiscount = 1;
state = [world.initPos;0];
for k = 1:world.maxIteration
    state_Reward = stateReward(world,state);
    action = generateAction(policy,state);
    accReward = accReward + accDiscount*state_Reward;
    accDiscount = accDiscount*world.timeDiscount;
    state = transferModel(world,state,action);
end
