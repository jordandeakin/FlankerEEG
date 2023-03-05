function startExperiment(coherence, trialsPerCondition)
% Initalise LabJack & Display
L =[];% initLJ_Matlab();
[data,w, filename, display] = initDisplay();
RestrictKeysForKbCheck(KbName('space'));


startBaseline(L,w,trialsPerCondition,display,filename,coherence,data);
startFlankerTask(L,w,trialsPerCondition,display,filename,coherence,data);




% Close LabJack
%closeLJ_Matlab(L)

% Free the keys!
RestrictKeysForKbCheck([])

leaderboard = createLeaderboard;
drawLeaderboard(w,leaderboard,data)

ShowCursor
% Close the Screen.
Screen('CloseAll')