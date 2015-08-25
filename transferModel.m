function newState = transferModel(world, state, action)
%% Written by Chenyang Zhao
% This is the function for transfer Model, 
% Input: world, the world struct containing the world settings
% state, the current state of the robot
% action, the current action of the robot 
% x(k+1) = Ax(k)+Bu(k)+noise;
%%
    newState = state;
    newState(1:2) = world.A*state(1:2) + world.B*action + mvnrnd([0 0], world.sigma.^2)';
    newState(1:2) = bsxfun(@max,[-20;-100],bsxfun(@min,newState(1:2),[20;100]));
end