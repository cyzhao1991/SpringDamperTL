function dJdTheta = thetaExplore(world, policy)
%% Written by Chenyang Zhao

%%
dJdTheta = zeros(1,world.maxTrail);
for i = 1:world.maxTrail
    accReward = 0;
    accGrad = 0;
    accDiscount = 1;
    state = [world.initPos;0];
    for k = 1:world.maxIteration
        state_Reward = stateReward(world,state);
        action = generateAction(policy,state);
        accReward = accReward + accDiscount*state_Reward;
        accDiscount = accDiscount*world.timeDiscount;
        accGrad = accGrad + dLogdTheta(policy,state,action);
    end
    dJdTheta(i) = accGrad*accReward;
end

end