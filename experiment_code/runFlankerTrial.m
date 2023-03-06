function trialMat = runFlankerTrial(L,trialMat,display,w)
[y, Fs] = audioread('incorrectTone.mp3');
RestrictKeysForKbCheck([KbName('z') KbName('m') KbName('q')])

for iTrial = 1:height(trialMat)

    targetDir = trialMat.TargetDir(iTrial);
    flankerDir = trialMat.FlankerDir(iTrial);
    coherence = trialMat.Coherence(iTrial);
    practice = trialMat.Practice(iTrial);
    condCode = trialMat.CondCode(iTrial);



    % Create RDK objects
    target = rdk('display',display,'nDots',50,'coherence',coherence,'direction',targetDir,'speed',3,'centre',[w.Xrect, w.Yrect],'lifetime',.5*w.frame_rate,'itemApertureSize',3);
    leftFlank = rdk('display',display,'nDots',50,'coherence',coherence,'direction',flankerDir,'speed',3,'centre',[w.Xrect-300; w.Yrect],'lifetime',.5*w.frame_rate,'itemApertureSize',3);
    rightFlank = rdk('display',display,'nDots',50,'coherence',coherence,'direction',flankerDir,'speed',3,'centre',[w.Xrect+300; w.Yrect],'lifetime',.5*w.frame_rate,'itemApertureSize',3);

    % Draw Initial Positions
    DrawFormattedText2('<size=20>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
    Screen('DrawDots', w.ptr, [target.dotX;target.dotY],2,[255 255 255],[],1);
    Screen('DrawDots', w.ptr, [leftFlank.dotX;leftFlank.dotY],2,[255 255 255],[],1);
    Screen('DrawDots', w.ptr, [rightFlank.dotX;rightFlank.dotY],2,[255 255 255],[],1);



    sendLJ_Matlab(L,8);
    [vbl, onsetTime] = Screen('Flip',w.ptr);



    responseMade = false;

    iFrame = 0;

    flagDir = 0;
    flagCoh = 0;
    flagCon = 0;
    flagPrac = 0;


    % Within trial loop
    while  ~responseMade || (GetSecs - onsetTime) < .8
        iFrame = iFrame + 1;



        if flagDir == 0 && GetSecs - onsetTime > .01
            flagDir = 1;
            sendLJ_Matlab(L,condCode(1))
        end

        if flagCoh == 0 && GetSecs - onsetTime > .02
            flagCoh = 1;
            sendLJ_Matlab(L,condCode(2))
        end

        if flagCon == 0 && GetSecs - onsetTime > .03
            flagCon = 1;
            sendLJ_Matlab(L,condCode(3))
        end

        if flagPrac == 0 && GetSecs - onsetTime > .04
            flagPrac = 1;
            sendLJ_Matlab(L,condCode(4));
        end

        % Animation
        moveDots(target); % move the dots.
        checkIfOut(target); % check if any dots are outside the aperture.
        checkIfDead(target); % check if any dots are dead.

        moveDots(leftFlank);
        checkIfOut(leftFlank);
        checkIfDead(leftFlank);

        moveDots(rightFlank);
        checkIfOut(rightFlank);
        checkIfDead(rightFlank);

        % Initialise dot postitions.
        DrawFormattedText2('<size=20>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
        Screen('DrawDots', w.ptr, [target.dotX;target.dotY],2,[255 255 255],[],1);
        Screen('DrawDots', w.ptr, [leftFlank.dotX;leftFlank.dotY],2,[255 255 255],[],1);
        Screen('DrawDots', w.ptr, [rightFlank.dotX;rightFlank.dotY],2,[255 255 255],[],1);
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
                    %   sendLJ_Matlab(L,2);
                else
                    trialMat.Correct(iTrial) = 0;
                    %  sendLJ_Matlab(L,3);
                end
            elseif keyCode(KbName('z')) == 1
                if targetDir == 180
                    trialMat.Correct(iTrial) = 1;
                    % sendLJ_Matlab(L,2);
                else
                    trialMat.Correct(iTrial) = 0;
                    %  sendLJ_Matlab(L,3);
                end
            end

            if practice && trialMat.Correct(iTrial) == 0
                sound(y, Fs, 16);
            end

        end
    end






    if mod(iTrial,32) == 0
        breakScreen(w);
    end

    % Pause for EEG
    DrawFormattedText2('<size=20>+','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
    Screen('Flip',w.ptr)
    pause(unifrnd(.2,.8));
end

RestrictKeysForKbCheck(KbName('space'))


