function startExperiment(coherence, trialsPerCondition)
L =[];% initLJ_Matlab();
[data,w, filename, display] = initDisplay();

RestrictKeysForKbCheck(KbName('space'));
startBaseline(L,w,trialsPerCondition,display,filename,coherence,data);
startFlankerTask(L,w,trialsPerCondition,display,filename,coherence,data);



% Close the Psychtoolbox Window.
ShowCursor
%closeLJ_Matlab(L)
Screen('CloseAll')