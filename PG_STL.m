clearvars -except 'poolobj';
close all;
clc;



%if ~exist('poolobj','var')
%    poolobj = parpool;
%end
profile on;
statevec = 'x,v,m';
klist = [1 2 3 4 5];
dlist = [0.01,0.05,0.1,0.2,0.5];
mlist = [0.5, 1, 2, 3, 5];
desPoslist = [1 2 3 4 5];
for taskNum = 1:5;
    m = mlist(taskNum);
    PGTest;
    result(taskNum).desPos = desPos;
    result(taskNum).policy = policy;
    result(taskNum).hisReward = hisReward;
    result(taskNum).hisPolicy = hisPolicy;
    result(taskNum).hisPolicy2 = hisPolicy2;
    result(taskNum).world = world;
end

profile off;
profile viewer;


delete(poolobj);