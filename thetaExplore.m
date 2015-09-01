function [dJdTheta, trailReward] = thetaExplore(world, policy)
%% Written by Chenyang Zhao

%%
dJdTheta = zeros(world.maxTrail,world.stateLength+2);
trailGrad = zeros(world.maxTrail,world.stateLength+2);
trailReward = zeros(world.maxTrail,1);
trailGradSquare = zeros(world.maxTrail,world.stateLength+2);
parfor i = 1:world.maxTrail
    accReward = 0;
    accGrad = 0;
    accDiscount = 1;
    state = world.initState;
    for k = 1:world.maxIteration
        action = generateAction(policy,state);
        state_Reward = stateReward(world,state,action);
        accReward = accReward + accDiscount*state_Reward;
        accDiscount = accDiscount*world.timeDiscount;
        dLogdTheta(policy,state,action);
        accGrad = accGrad + dLogdTheta(policy,state,action);
        
        state = transferModel(world,state,action);
    end
    trailGrad(i,:) = accGrad;
    trailGradSquare(i,:) = accGrad.^2;
    trailReward(i,:) = accReward;
end
trailGrad;
baseline = mean(bsxfun(@times,trailGradSquare,trailReward))./mean(trailGradSquare);
dJdTheta = bsxfun(@times,trailGrad,(bsxfun(@minus,repmat(trailReward,1,world.stateLength+2), baseline)));
%dJdTheta(:,4) = 0;

dJdTheta = mean(dJdTheta);
end