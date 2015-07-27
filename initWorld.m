function world = initWorld(k, c, m, sigma, f, initPos, desPos, timeDiscount)
% world = initWorld creates a world struct containing all the setting
% parameters.
% k is the spring constant, c is the damper constant, f is the update frequency.
% sigma is the noise variance of the actuator.
% initPos is the position with no spring force.
% desPos is the desired position.
% model is x' = A1x + B1u + noise, 
% x(k+1) = (dtA1+I)x(k) + dtB1u(k) + noise = Ax(k)+Bu(k)+noise 
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
    world.A1 = [-c/m -k/m;
        1 0];
    world.B1 = [1/m;
        0];
    world.A = world.dt*world.A1+eye(2);
    world.B = world.dt*world.B1;
    world.timeDiscount = timeDiscount;
end