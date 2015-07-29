function [dJdTheta, trailReward] = thetaExplore(world, policy)
%% Written by Chenyang Zhao

%%
dJdTheta = zeros(world.maxTrail,4);
trailGrad = zeros(world.maxTrail,4);
trailReward = zeros(world.maxTrail,1);
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
        
        state = transferModel(world,state,action);
    end
    trailGrad(i,:) = accGrad;
    trailReward(i,:) = accReward;
end
dJdTheta = bsxfun(@times,trailGrad,(trailReward - mean(trailReward)));
dJdTheta(:,4) = 0;
end