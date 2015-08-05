function r = stateReward(world, state, action)
%% Written by Chenyang Zhao
% get the state reward of current state
% State Reward is defined as 
%% 
    state_error = state(1:2) - [world.desPos; 0];
    %vel_error = state(2) - 0;
    r = - state_error'*world.Q*state_error - action'*world.R*action;
%     if abs(pos_error)>0.1
%         r = r - 2;
%     end
    %r = max(r,-50);
end