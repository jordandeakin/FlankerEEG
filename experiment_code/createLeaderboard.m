function leaderboard = createLeaderboard()
addpath('./Data');
%if isfile('leaderboard.mat')
   % load('leaderboard.mat');
   


%else
singleFiles = dir('./Data/Single*');
flankerFiles = dir('./Data/Flanker*');

[RTSingle,RTFlanker,AccSingle, AccFlanker, RT,ACC,uid] = deal(zeros(length(singleFiles),1));
for iFile = 1:length(singleFiles)
    
    dataSingle = load(singleFiles(iFile).name);
    dataFlanker = load(flankerFiles(iFile).name);

    RTSingle(iFile) = median(dataSingle.trialSequence.RT(dataSingle.trialSequence.Practice == 0));
    RTFlanker(iFile) = median(dataFlanker.trialSequence.RT(dataFlanker.trialSequence.Practice == 0));

    AccSingle(iFile) = mean(dataSingle.trialSequence.Correct(dataSingle.trialSequence.Practice == 0));
    AccFlanker(iFile) = mean(dataFlanker.trialSequence.Correct(dataFlanker.trialSequence.Practice == 0));

    uid(iFile) = dataSingle.demographics.ID;
    RT(iFile) = mean([RTSingle(iFile) RTFlanker(iFile)]);
    ACC(iFile) = mean([AccSingle(iFile) AccFlanker(iFile)]);
end
leaderboard = table();
leaderboard.ID = uid;
leaderboard.RT = RT*1000;
leaderboard.Acc = ACC;
leaderboard.IES = leaderboard.RT./leaderboard.Acc;
save('leaderboard.mat','leaderboard');
%end

leaderboard = sortrows(leaderboard,"Acc","descend");

