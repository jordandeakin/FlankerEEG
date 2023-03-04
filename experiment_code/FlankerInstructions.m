function FlankerInstructions(w)

DrawFormattedText2('Now, you will see <b><u>THREE<b><u> fields of dots (RDKS).','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press space to continue','center',w.Yrect+300,[0 255 255],100,[],[],2);
Screen('Flip',w.ptr);
KbPressWait;


instructionsText = 'The task is to <b><u>report the direction of motion<b><u> in the <b>CENTER RDK<b>\n(leftwards or rightwards).';
DrawFormattedText2(instructionsText,'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbStrokeWait;

controlText = strcat('If the motion in the <b><u><i>CENTRE RDK<b><u><i> is travelling <b><i>LEFTWARDS<b><i>, press ''<b>z<b>''.',...
    '\n\nIf the motion in the <b><u><i>CENTRE RDK<b><u><i> is travelling <b><i>RIGHTWARDS<b><i>, press ''<b>m<b>''.');

DrawFormattedText2(controlText,'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press space to continue.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
Screen('Flip',w.ptr);
KbPressWait;

% 
% DrawFormattedText(w.ptr,"We will first do some practice trials. You will receive feedback through the fixation cross (green for correct, red for incorrect).",'center','center',[255 255 255],100,[],[],2);
% DrawFormattedText(w.ptr,'Press space to start!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);
% 
% 

