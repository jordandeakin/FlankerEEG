function startExperiment(coherence, trialsPerCondition)
% Initalise LabJack & Display
L =[];%initLJ_Matlab();

% Start Experiment Trigger
%sendLJ_Matlab(L, 98);


[data,w, filename, display] = initDisplay();
RestrictKeysForKbCheck(KbName('space'));


startBaseline(L,w,trialsPerCondition,display,filename,coherence,data);
%startFlankerTask(L,w,trialsPerCondition,display,filename,coherence,data);




% Close LabJack
%sendLJ_Matlab(L, 99);
%closeLJ_Matlab(L)

% Free the keys!
RestrictKeysForKbCheck([])

leaderboard = createLeaderboard;
drawLeaderboard(w,leaderboard,data)

ShowCursor
% Close the Screen.
Screen('CloseAll')