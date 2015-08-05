clearvars -except 'poolobj';
close all;
clc;



if ~exist('poolobj','var')
    poolobj = parpool;
end
profile on;

for desPos = 1:5;
    PGTest;
    result(desPos).desPos = desPos;
    result(desPos).policy = policy;
    result(desPos).hisReward = hisReward;
    result(desPos).hisPolicy = hisPolicy;
    result(desPos).hisPolicy2 = hisPolicy2;
    result(desPos).world = world;
end

profile off;
profile viewer;

delete(poolobj);