function world = initWorld(k, c, m, sigma, f, initPos, desPos, Q,R,timeDiscount, maxIteration, maxTrail,statevec)
% world = initWorld creates a world struct containing all the setting
% parameters.
% k is the spring constant, c is the damper constant, f is the update frequency.
% sigma is the noise variance of the actuator.
% initPos is the position with no spring force.
% desPos is the desired position.
% model is x' = A1x + B1u + noise, 
% x(k+1) = (dtA1+I)x(k) + dtB1u(k) + noise = Ax(k)+Bu(k)+noise 
% maxIteration indicates the max time step in one trail.
% maxTrail indicate the max number of trails that are used for estimating
% dJdTheta for a certain policy.
%%
    world = struct();
    world.k = k;
    world.c = c;
    world.m = m;
    world.sigma = sigma;
    world.f = f;
    world.dt = 1/f;
    world.initPos = initPos;
    world.desPos = desPos;
    world.A1 = [0 1;
        -k/m -c/m];
    world.B1 = [0;
        1/m];
    world.A = world.dt*world.A1+eye(2);
    world.B = world.dt*world.B1;
    world.Q = Q;
    world.R = R;
    world.timeDiscount = timeDiscount;
    world.maxIteration = maxIteration;
    world.maxTrail = maxTrail;
    world.statevec = statevec;
    
    c = strsplit(statevec,',');
    
    world.stateLength = length(c);
    world.initState = zeros(length(c),1);
    world.initState(1:2) = [initPos, 0];
    for i = 3:length(c)
        world.initState(i) = getfield(world,c{i});
    end
    
end