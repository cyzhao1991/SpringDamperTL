function [animation, hisState] = makeAnimation(world,policy)
close all;
figure(1);
%b = plot(world.desPos, 3 , 'Marker', 'o', 'MarkerFaceColor', 'r');
policy.theta.sigma = 0
state = [world.initPos;0];
animation = plot(state(1),3,'Marker','o','MarkerFaceColor' ,'b');
axis([-2 5 1 5]);
hisState = zeros(world.maxIteration,2);
accDis = 1;
accReward = 0;
for i = 1:world.maxIteration
    action = generateAction(policy,state);
    state = transferModel(world,state,action);
    set(animation,'XData',state(1));
    pause(0.01);
    stateReward(world,state)
    accReward = accReward + accDis*stateReward(world,state);
    accDis = accDis*world.timeDiscount;
    if norm(state - [world.desPos;0]) < 0.01;
        break
    end
    hisState(i,:) = state';
end
accReward