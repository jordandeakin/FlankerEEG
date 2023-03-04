function data = startBaseline(L,w,trialsPerCondition,display,filename,coherence,data)
% Instructions
BaselineInstructions(w);
data.trialSequence = [];


% Experiment is split into four blocks...
for iBlock = 1:4

    if iBlock == 1
        % If it is the first block, the amount of practice trials are
        % doubled.
        practiceMatrix = [createTrialMatrix(coherence,"Single",trialsPerCondition/4,1); createTrialMatrix(coherence,"Single",trialsPerCondition/4,1)];
        DrawFormattedText2('We will first do some practice trials with feedback. \nYou will hear an error tone if your response is incorrect.\nTry to respond as <b><u>quickly<b><u> and as <b><u>accurately<u><b> as possible.\n\n','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
        Screen('Flip',w.ptr);
        KbStrokeWait;
    else
        practiceMatrix = createTrialMatrix(coherence,"Single",trialsPerCondition/4,1);
        DrawFormattedText2(sprintf('<color=00FFFF><b><u>Block %d of 4 complete!<b><u><color>\n\nLet''s do some more practice trials...',iBlock-1),'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
        Screen('Flip',w.ptr);
        KbStrokeWait;
    end

    %% Practice Trials
    practiceMatrix = runBaselineTrial(L,practiceMatrix,display,w);
    practiceMatrix.Block = repmat(iBlock,height(practiceMatrix),1);

    % Tell participant that practice trials are over.
    DrawFormattedText(w.ptr,'That is the end of the practice trials\nReady?','center','center',[255 255 255],100,[],[],2)
    DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);
    Screen('Flip',w.ptr);
    KbStrokeWait;


    %% Experimental Trials.
    trialMatrix = createTrialMatrix(coherence,"Single",trialsPerCondition/4,0);
    trialMatrix = runBaselineTrial(L,trialMatrix,display,w);
    trialMatrix.Block = repmat(iBlock,height(trialMatrix),1);


    % Append the sequence...
    data.trialSequence = [data.trialSequence; practiceMatrix; trialMatrix];
    save(sprintf('./Data/Single_%s.mat',filename), '-struct','data')

    % If last block, say thank you!
    if iBlock == 4
        endTask(w,data.trialSequence)
    end

end