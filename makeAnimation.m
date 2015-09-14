function [animation, hisState, accReward] = makeAnimation(world,policy,ifDraw)
%close all;
if nargin<3
    ifDraw = true;
end

if ~ifDraw
    animation = [];
end

policy.theta.sigma = 0;
state = world.initState;
hisState = zeros(world.maxIteration,world.stateLength);
accDis = 1;
accReward = 0;
policy.theta.sigma = 0.00001;
stateRewards = [];

if ifDraw
    figure(1);
    %b = plot(world.desPos, 3 , 'Marker', 'o', 'MarkerFaceColor', 'r');

    animation = plot(state(1),3,'Marker','o','MarkerFaceColor' ,'b');
    axis([-2 5 1 5]);
    grid on;
end

for i = 1:world.maxIteration
    action = generateAction(policy,state);
    state = transferModel(world,state,action);
    if ifDraw
        set(animation,'XData',state(1));
        pause(0.01);
    end
    stateRewards = [stateRewards stateReward(world,state,action)];
    accReward = accReward + accDis*stateReward(world,state,action);
    accDis = accDis*world.timeDiscount;

    hisState(i,:) = state';
end
accReward
if ifDraw
    figure(2)
    plot(stateRewards)
end
