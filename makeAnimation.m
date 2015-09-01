function [animation, hisState] = makeAnimation(world,policy)
%close all;
figure(1);
%b = plot(world.desPos, 3 , 'Marker', 'o', 'MarkerFaceColor', 'r');
policy.theta.sigma = 0
state = world.initState;
animation = plot(state(1),3,'Marker','o','MarkerFaceColor' ,'b');
axis([-2 5 1 5]);
grid on;
hisState = zeros(world.maxIteration,world.stateLength);
accDis = 1;
accReward = 0;
policy.theta.sigma = 0.00001;
stateRewards = [];
for i = 1:world.maxIteration
    action = generateAction(policy,state);
    state = transferModel(world,state,action);
    set(animation,'XData',state(1));
    pause(0.01);
    stateRewards = [stateRewards stateReward(world,state,action)];
    accReward = accReward + accDis*stateReward(world,state,action);
    accDis = accDis*world.timeDiscount;

    hisState(i,:) = state';
end
accReward
figure(2)
plot(stateRewards)