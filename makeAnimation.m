function animation = makeAnimation(world,policy)
close all;
figure(1);
%b = plot(world.desPos, 3 , 'Marker', 'o', 'MarkerFaceColor', 'r');
policy.theta.sigma = 0
state = [world.initPos;0];
h = plot(state(1),3,'Marker','o','MarkerFaceColor' ,'b');
axis([-2 5 1 5]);
for i = 1:world.maxIteration
    action = generateAction(policy,state);
    state = transferModel(world,state,action);
    set(h,'XData',state(1));
    pause(0.01);
    state(1);
    stateReward(world,state)
    if norm(state - [world.desPos;0]) < 0.01;
        break
    end
end