function r = stateReward(world, state)
%% Written by Chenyang Zhao
% get the state reward of current state
% State Reward is defined as 
%% 
    pos_error = state(1) - world.desPos;
    vel_error = state(2) - 0;
    r = - pos_error'*world.Q*pos_error - vel_error'*world.R*vel_error;
    r = max(r,-50);
end