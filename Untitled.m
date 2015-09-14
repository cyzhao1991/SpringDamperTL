% clearvars -except 'poolobj' 
% load ('STL_k.mat','result');
% clc;
% close all;
% 
% dlist = [0.01,0.05,0.1,0.2,0.5];
% klist = [1 2 3 4 5];
% mlist = [0.5 1 2 3 5];
% desPoslist = [1 2 3 4 5];
% statevec = 'x,v';
% k = 3;
% T = length(desPoslist);
% 
% sigma = [0.001 0.001];
% f = 100;    %Hz
% initPos = 0;
% Q = diag([1,0.05]);
% R = 0*eye(1);
% timeDiscount = 0.999;
% maxIteration = 300;
% maxTrail = 100;
% learningrate = 0.001;
% 
% for i = 1:T
%     worldlist(i) = initWorld(klist(i),dlist(1), mlist(1), sigma, f, initPos, desPoslist(4), Q, R,...
%         timeDiscount, maxIteration, maxTrail,statevec);
% end
% MTL
% save('MTL_k.mat')

%% 2
clearvars -except 'poolobj' 
load ('STL_d.mat','result');
clc;
close all;

dlist = [0.01,0.05,0.1,0.2,0.5];
klist = [1 2 3 4 5];
mlist = [0.5 1 2 3 5];
desPoslist = [1 2 3 4 5];
somelist = dlist;

statevec = 'x,v';
k = 3;
T = length(desPoslist);

sigma = [0.001 0.001];
f = 100;    %Hz
initPos = 0;
Q = diag([1,0.05]);
R = 0*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;
learningrate = 0.001;

for i = 1:T
    worldlist(i) = initWorld(klist(1),dlist(i), mlist(1), sigma, f, initPos, desPoslist(4), Q, R,...
        timeDiscount, maxIteration, maxTrail,statevec);
end
MTL_G
save('GMTL_d.mat')

%% 3
clearvars -except 'poolobj' 
load ('STL_m.mat','result');
clc;
close all;

dlist = [0.01,0.05,0.1,0.2,0.5];
klist = [1 2 3 4 5];
mlist = [0.5 1 2 3 5];
desPoslist = [1 2 3 4 5];
somelist = mlist;
statevec = 'x,v';
k = 3;
T = length(desPoslist);

sigma = [0.001 0.001];
f = 100;    %Hz
initPos = 0;
Q = diag([1,0.05]);
R = 0*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;
learningrate = 0.001;

for i = 1:T
    worldlist(i) = initWorld(klist(1),dlist(1), mlist(i), sigma, f, initPos, desPoslist(4), Q, R,...
        timeDiscount, maxIteration, maxTrail,statevec);
end
MTL_G
save('GMTL_m.mat')

% %% 4 
% clearvars -except 'poolobj' 
% load ('PSTL_k.mat','result');
% clc;
% close all;
% 
% dlist = [0.01,0.05,0.1,0.2,0.5];
% klist = [1 2 3 4 5];
% mlist = [0.5 1 2 3 5];
% desPoslist = [1 2 3 4 5];
% statevec = 'x,v,k';
% k = 3;
% T = length(desPoslist);
% 
% sigma = [0.001 0.001];
% f = 100;    %Hz
% initPos = 0;
% Q = diag([1,0.05]);
% R = 0*eye(1);
% timeDiscount = 0.999;
% maxIteration = 300;
% maxTrail = 100;
% learningrate = 0.001;
% 
% for i = 1:T
%     worldlist(i) = initWorld(klist(i),dlist(1), mlist(1), sigma, f, initPos, desPoslist(4), Q, R,...
%         timeDiscount, maxIteration, maxTrail,statevec);
% end
% MTL
% save('PMTL_k.mat')

%% 5
% clearvars -except 'poolobj' 
% load ('PSTL_d.mat','result');
% clc;
% close all;
% 
% dlist = [0.01,0.05,0.1,0.2,0.5];
% klist = [1 2 3 4 5];
% mlist = [0.5 1 2 3 5];
% 
% desPoslist = [1 2 3 4 5];
% statevec = 'x,v,d';
% k = 3;
% T = length(desPoslist);
% 
% sigma = [0.001 0.001];
% f = 100;    %Hz
% initPos = 0;
% Q = diag([1,0.05]);
% R = 0*eye(1);
% timeDiscount = 0.999;
% maxIteration = 300;
% maxTrail = 100;
% learningrate = 0.001;
% 
% for i = 1:T
%     worldlist(i) = initWorld(klist(1),dlist(i), mlist(1), sigma, f, initPos, desPoslist(4), Q, R,...
%         timeDiscount, maxIteration, maxTrail,statevec);
% end
% MTL
% save('PMTL_d.mat')

%% 6
% clearvars -except 'poolobj' 
% load ('PSTL_m.mat','result');
% clc;
% close all;
% 
% dlist = [0.01,0.05,0.1,0.2,0.5];
% klist = [1 2 3 4 5];

% mlist = [0.5 1 2 3 5];
% desPoslist = [1 2 3 4 5];
% statevec = 'x,v,m';
% k = 3;
% T = length(desPoslist);
% 
% sigma = [0.001 0.001];
% f = 100;    %Hz
% initPos = 0;
% Q = diag([1,0.05]);
% R = 0*eye(1);
% timeDiscount = 0.999;
% maxIteration = 300;
% maxTrail = 100;
% learningrate = 0.001;
% 
% for i = 1:T
%     worldlist(i) = initWorld(klist(1),dlist(1), mlist(i), sigma, f, initPos, desPoslist(4), Q, R,...
%         timeDiscount, maxIteration, maxTrail,statevec);
% end
% MTL
% save('PMTL_m.mat')
%% 7
clearvars -except 'poolobj' 
load ('STL_desPos.mat','result');
clc;
close all;

dlist = [0.01,0.05,0.1,0.2,0.5];
klist = [1 2 3 4 5];
mlist = [0.5 1 2 3 5];
desPoslist = [1 2 3 4 5];
somelist = desPoslist;
statevec = 'x,v';
k = 3;
T = length(desPoslist);

sigma = [0.001 0.001];
f = 100;    %Hz
initPos = 0;
Q = diag([1,0.05]);
R = 0*eye(1);
timeDiscount = 0.999;
maxIteration = 300;
maxTrail = 100;
learningrate = 0.001;

for i = 1:T
    worldlist(i) = initWorld(klist(1),dlist(1), mlist(1), sigma, f, initPos, desPoslist(i), Q, R,...
        timeDiscount, maxIteration, maxTrail,statevec);
end
MTL_G
save('GMTL_desPos.mat')
