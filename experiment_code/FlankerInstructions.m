function FlankerInstructions(w)

        

Screen('TextSize',w.ptr,18);
DrawFormattedText(w.ptr,'Now you will see THREE circular fields of moving dots (RDKs).','center','center',[255 255 255],40,[],[],2);
DrawFormattedText(w.ptr,'Press space to continue','center',w.Yrect+300,[0 255 255],100,[],[],2);
Screen('Flip',w.ptr);
Screen('TextSize',w.ptr,18);
KbPressWait;


instructionsText = strcat('The task is to report the direction of motion in the CENTER RDK\n  (left or right).');


DrawFormattedText(w.ptr,instructionsText,'center','center',[255 255 255],100,[],[],2)%'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','wrapat',100);%'baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbStrokeWait;

controlText = strcat('If the motion in the CENTRE RDK is travelling LEFTWARDS, press ''z''.',...
    '\n\nIf the motion in the CENTRE RDK is travelling RIGHTWARDS, press ''m''.');

DrawFormattedText(w.ptr,controlText,'center','center',[255 255 255],100,[],[],2);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbPressWait;

% 
% DrawFormattedText(w.ptr,"We will first do some practice trials. You will receive feedback through the fixation cross (green for correct, red for incorrect).",'center','center',[255 255 255],100,[],[],2);
% DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
% 
% 

