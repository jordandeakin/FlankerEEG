function trialMat = runBaselineTrial(L,trialMat,display,w)
RestrictKeysForKbCheck([KbName('z') KbName('m') KbName('q')]);

% Feedback is auditory by default but feedback can be provided through the
% fixation cross colour if needed.
[y, Fs] = audioread('incorrectTone.mp3');
%fix_colour = [255 255 255];

for iTrial = 1:height(trialMat)

    % Trial Settings
    targetDir = trialMat.TargetDir(iTrial);
    coherence = trialMat.Coherence(iTrial);
    practice = trialMat.Practice(iTrial);
    condCode = trialMat.CondCode(iTrial);



    % Create RDK objects
    target = rdk('display',display,'nDots',50,'coherence',coherence,'direction',targetDir,'speed',3,'centre',[w.Xrect, w.Yrect],'lifetime',.5*w.frame_rate,'itemApertureSize',3);

    % Fixation Cross
    DrawFormattedText2('<size=64>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
   % sendLJ_Matlab(L,1); % Send Fixation to LJ.
    Screen('Flip',w.ptr);
    WaitSecs(.5)


    % Draw initial positions.
    Screen('DrawDots', w.ptr, [target.dotX;target.dotY],2,[255 255 255],[],1);



    %sendLJ_Matlab(L,condCode); % Send the condition code to LabJack
    vbl = Screen('Flip',w.ptr);
    onsetTime = GetSecs; % Get the onset time of the flip. Used to calculate RT.


    responseMade = false;
    iFrame = 0;

    % Within trial loop
    while ~responseMade
        iFrame = iFrame + 1;

        % Animation
        moveDots(target); % move the dots.
        checkIfOut(target); % check if any dots are outside the aperture.
        checkIfDead(target); % check if any dots are dead.


        % Reinitialise dot postitions.
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
                    % sendLJ_Matlab(L,2); % Send Correct Response to
                    % LabJack
                   % fix_colour = [0, 255, 0];
                else
                    trialMat.Correct(iTrial) = 0;
                    %  sendLJ_Matlab(L,3); % Send incorrect response to
                    %  LabJack.
                  %  fix_colour = [255, 0, 0];
                end
            elseif keyCode(KbName('z')) == 1
                if targetDir == 180
                    trialMat.Correct(iTrial) = 1;
                    % sendLJ_Matlab(L,2);
                  %  fix_colour = [0, 255, 0];
                else
                    trialMat.Correct(iTrial) = 0;
                    % sendLJ_Matlab(L,3);
                  %  fix_colour = [255,0, 0];
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
    %    Screen('Flip',w.ptr)
    %pause(.5)

end

RestrictKeysForKbCheck(KbName('space'))
