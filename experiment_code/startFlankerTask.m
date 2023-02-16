function data = startFlankerTask(L,w,trialsPerCondition,display,filename,coherence,data)
% Instructions
FlankerInstructions(w);

data.trialSequence = [];


% Experiment is split into four blocks...
for iBlock = 1:4

    if iBlock == 1
        % If it is the first block, the amount of practice trials are
        % doubled.
        practiceMatrix = [createTrialMatrix(coherence,"Flanker",trialsPerCondition/4,1); createTrialMatrix(coherence,"Flanker",trialsPerCondition/4,1)];
        DrawFormattedText(w.ptr,'We will first do some practice trials.\n\n','center','center',[255 255 255],100,[],[],2);
        DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
        Screen('Flip',w.ptr);
        KbStrokeWait;
    else
        practiceMatrix = createTrialMatrix(coherence,"Flanker",trialsPerCondition/4,1);
        DrawFormattedText(w.ptr,sprintf('Block %d of 4 complete. Well done!\n\nWe will do some more practice trials.\n\n',iBlock-1),'center','center',[255 255 255],100,[],[],2);%'baseColor',[255 255 255]);
        DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
        Screen('Flip',w.ptr);
        KbStrokeWait;
    end

    %% Practice Trials
    practiceMatrix = runFlankerTrial(L,practiceMatrix,display,w); 
practiceMatrix.Block = repmat(iBlock,height(practiceMatrix),1);

    % Tell participant that practice trials are over.
    DrawFormattedText(w.ptr,'That is the end of the practice trials.\n\n','center','center',[255 255 255],100,[],[],2)
    DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);
    Screen('Flip',w.ptr);
    KbStrokeWait;


    %% Experimental Trials.
    trialMatrix = createTrialMatrix(coherence,"Flanker",trialsPerCondition/4,0);
       trialMatrix = runFlankerTrial(L,trialMatrix,display,w);
    trialMatrix.Block = repmat(iBlock,height(trialMatrix),1);


    % Append the sequence...
    data.trialSequence = [data.trialSequence; practiceMatrix; trialMatrix];
    save(sprintf('Flanker_%s.mat',filename), '-struct','data')

    % If last block, say thank you!
    if iBlock == 4
        endTask(w,data.trialSequence)
    end

end