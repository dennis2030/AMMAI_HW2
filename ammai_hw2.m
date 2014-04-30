
%init
clear ; close all; clc

%% Here you need to add SPAMS to the matlab path
%% If you are on cmlab server you might be able to use following path
%addpath('/home/master/99/sirius42/resources/spams-v2.4/build');

%%Part1 - baseline for face image retrieval
% In this part you need to finish l2Distance.m and calculateMAP.m
fprintf('Loading data...\n');
load('LFW_DATA');

fprintf('Computing distance...\n');
distance = l2Distance(LFW_DATA.queryFeature, LFW_DATA.databaseFeature);

fprintf('calculate mean average precision...\n');
result = calculateMAP(distance, LFW_DATA.queryIdentity, LFW_DATA.databaseIdentity);

fprintf('MAP for L2 Distance: %f\n', result);
fprintf('If every thing is correct, the MAP should be around 0.102\n');
fprintf('Program paused. Press enter to continue.\n');
pause;

%%Part2 - sparse coding for face image retrieval
%% In this part, you need to finish sparseCoding.m

fprintf('Running sparse coding...(it might takes a while to run)\n');
tic;
[querySR databaseSR D] = sparseCoding(LFW_DATA.queryFeature, LFW_DATA.databaseFeature);
toc;
% Here we compute the distance using matrix multiplication,
% but when dealing with large-scale problem, we can adpot inverted indexing
fprintf('Computing distance...\n');
%querySR(find(querySR~=0)) = 1;
%databaseSR(find(databaseSR~=0)) = 1;
databaseSR = addIdentity(databaseSR, LFW_DATA.databaseIdentity);
%distance = -1*querySR*databaseSR';

distance = computeDistance(querySR, databaseSR, 60);

fprintf('Calculate mean average precision...\n');
result = calculateMAP(distance, LFW_DATA.queryIdentity, LFW_DATA.databaseIdentity);
fprintf('MAP for Sparse Coding: %f\n', result);
fprintf('If every thing is correct, the MAP should be around 0.148\n');
generateUpload(distance, LFW_DATA, 'bean.out');
