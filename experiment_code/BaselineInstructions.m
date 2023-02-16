function BaselineInstructions(w)
c = clock;
        c = fix(c);
        
        if c(4) <= 12
            welcome = 'Good Morning';
        else
            welcome = 'Good Afternoon';
        end
        

Screen('TextSize',w.ptr,18);
DrawFormattedText(w.ptr,sprintf('%s\n\n\n In this task, you will see a circular field of moving dots known as a random-dot kinematogram (RDK).',welcome),'center','center',[255 255 255],40,[],[],2);
DrawFormattedText(w.ptr,'Press space to continue','center',w.Yrect+300,[0 255 255],100,[],[],2);
Screen('Flip',w.ptr);
Screen('TextSize',w.ptr,18);
KbPressWait;


instructionsText = strcat('Within the RDK, some of the dots move coherently to create a smooth motion signal, while the rest move randomly.',...
    '\n\nThe task is to report the direction of motion in the RDK\n  (left or right).');


DrawFormattedText(w.ptr,instructionsText,'center','center',[255 255 255],100,[],[],2)%'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','wrapat',100);%'baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbStrokeWait;


controlText = strcat('If the motion is travelling LEFTWARDS, press ''z''.',...
    '\n\nIf the motion is travelling RIGHTWARDS, press ''m''.');

DrawFormattedText(w.ptr,controlText,'center','center',[255 255 255],100,[],[],2);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbPressWait;

% 
% DrawFormattedText(w.ptr,"We will first do some practice trials. You will receive feedback through the fixation cross (green for correct, red for incorrect).",'center','center',[255 255 255],100,[],[],2);
% DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
% 
% 

