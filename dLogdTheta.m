function a = dLogdTheta(policy,state,action)
%% Written by Chenyang Zhao

    
state = [state;1];
dLogdK = (action - policy.theta.k*state)*state'/policy.theta.sigma^2;
dLogdSigma = -1/policy.theta.sigma + (action - policy.theta.k*state)^2/(policy.theta.sigma^3);

a = [dLogdK, dLogdSigma];

end