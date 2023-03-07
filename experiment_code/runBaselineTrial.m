function trialMat = runBaselineTrial(L,trialMat,display,w)
RestrictKeysForKbCheck([KbName('z') KbName('m') KbName('q')]);

% Feedback is auditory by default but feedback can be provided through the
% fixation cross colour if needed.
[y, Fs] = audioread('incorrectTone.mp3');


for iTrial = 1:height(trialMat)

    % Trial Settings
    targetDir = trialMat.TargetDir(iTrial);
    coherence = trialMat.Coherence(iTrial);
    practice = trialMat.Practice(iTrial);
    condCode = str2double(regexp(num2str(trialMat.CondCode(iTrial)),'\d','match'));
    numericCode = trialMat.CondCode(iTrial);


    % Create RDK objects
    target = rdk('display',display,'nDots',50,'coherence',coherence,'direction',targetDir,'speed',3,'centre',[w.Xrect, w.Yrect],'lifetime',.5*w.frame_rate,'itemApertureSize',3);

    % Draw initial dots
    % DrawFormattedText2('<size=20>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
    Screen('DrawLine',w.ptr,[255 255 255],w.Xrect-3,w.Yrect,w.Xrect+3,w.Yrect,1);
    Screen('DrawLine',w.ptr,[255 255 255],w.Xrect,w.Yrect-3,w.Xrect,w.Yrect+3,1);

    Screen('DrawDots', w.ptr, [target.dotX;target.dotY],2,[255 255 255],[],1);
     sendLJ_Matlab(L,5); % Send the condition code to LabJack]
    [vbl, onsetTime] = Screen('Flip',w.ptr);



    responseMade = false;

    iFrame = 0;

    flagDir = 0;
    flagCoh = 0;
    flagPrac = 0;

    clc
    % Within trial loop
    while ~responseMade || (GetSecs - onsetTime) < .8
        iFrame = iFrame + 1;



        if flagDir == 0 && GetSecs - onsetTime > .01
            flagDir = 1;
             sendLJ_Matlab(L,condCode(1))
        end

        if flagCoh == 0 && GetSecs - onsetTime > .02
            flagCoh = 1;
             sendLJ_Matlab(L,condCode(2))
        end

        if flagPrac == 0 && GetSecs - onsetTime > .03
            flagPrac = 1;
            sendLJ_Matlab(L,condCode(3));
        end


     
        % Animation
        moveDots(target); % move the dots.
        checkIfOut(target); % check if any dots are outside the aperture.
        checkIfDead(target); % check if any dots are dead.

        DrawFormattedText2(sprintf('%d',numericCode),'win',w.ptr,'sx','center','sy',w.Yrect-500,'xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);

        % Reinitialise dot postitions.
        %     DrawFormattedText2('<size=20>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
        Screen('DrawLine',w.ptr,[255 255 255],w.Xrect-3,w.Yrect,w.Xrect+3,w.Yrect,1);
        Screen('DrawLine',w.ptr,[255 255 255],w.Xrect,w.Yrect-3,w.Xrect,w.Yrect+3,1);
        Screen('DrawDots', w.ptr, [target.dotX;target.dotY],2,[255 255 255],[],1);
        [vbl] =  Screen('Flip',w.ptr,vbl + 0.5 * w.ifi);



        [ keyIsDown, secs, keyCode ] = KbCheck;
        % Check for quits.
        if keyIsDown && keyCode(KbName('q'))
            sca
            error('quit')
        end

        if keyIsDown == 1
            responseMade = true;
            trialMat.RT(iTrial) = secs - onsetTime;

            if keyCode(KbName('m')) == 1
                if targetDir == 0
                    trialMat.Correct(iTrial) = 1;
                    sendLJ_Matlab(L,2); % Send Correct Response to
                    % LabJack
                else
                    trialMat.Correct(iTrial) = 0;
                    sendLJ_Matlab(L,3); % Send incorrect response to
                    %  LabJack.
                end
            elseif keyCode(KbName('z')) == 1
                if targetDir == 180
                    trialMat.Correct(iTrial) = 1;
                    sendLJ_Matlab(L,2);
                else
                    trialMat.Correct(iTrial) = 0;
                    sendLJ_Matlab(L,3);
                end
            end

            % If it is a practice trial, give auditory feedback.
            if practice && trialMat.Correct(iTrial) == 0
                sound(y, Fs, 16);
            end
        end
    end





    % Every 32 trials, give the participant a break.
    if mod(iTrial,32) == 0
        breakScreen(w);
    end

    % Pause for EEG
    %  DrawFormattedText2('<size=20>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
    Screen('DrawLine',w.ptr,[255 255 255],w.Xrect-3,w.Yrect,w.Xrect+3,w.Yrect,1);
    Screen('DrawLine',w.ptr,[255 255 255],w.Xrect,w.Yrect-3,w.Xrect,w.Yrect+3,1);

    Screen('Flip',w.ptr);
    pause(unifrnd(.2,.8));

end

RestrictKeysForKbCheck(KbName('space'))
