function dJdTheta = thetaExplore(world, policy)
%% Written by Chenyang Zhao

%%
accReward = 0;
accGrad = 0;
accDiscount = 1;
state = world.initPos;
for i = 1:world.maxIteration
    state_Reward = stateReward(world,state);
    action = generateAction(policy,state);
    accReward = accReward + accDiscount*state_Reward;
    
end
end