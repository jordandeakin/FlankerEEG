function BaselineInstructions(w)
c = clock;
c = fix(c);

if c(4) <= 12
    welcome = 'Good Morning';
else
    welcome = 'Good Afternoon';
end



DrawFormattedText2(sprintf('<color=00FFFF><b>%s!<b><color>\n\n\n\nIn this task, you will see a circular field of moving dots known as a <b>random dot kinematogram<b>.',welcome),'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);

DrawFormattedText(w.ptr,'Press space to continue','center',w.Yrect+300,[0 255 255],100,[],[],2);
Screen('Flip',w.ptr);

KbPressWait;


instructionsText = strcat('Within the RDK, some of the dots move coherently to create a smooth motion signal, while the rest move randomly.',...
    '\n\nThe task is to <b><u>report the direction of motion<b><u> in the RDK\n  (leftwards or rightwards).');

DrawFormattedText2(instructionsText,'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);

DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbStrokeWait;


controlText = strcat('If the motion is travelling <b><i>LEFTWARDS<b><i>, press ''<b>z<b>''.',...
    '\n\nIf the motion is travelling <b><i>RIGHTWARDS<b><i>, press ''<b>m<b>''.');

DrawFormattedText2(controlText,'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbPressWait;



