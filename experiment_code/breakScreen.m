function breakScreen(w)
RestrictKeysForKbCheck([KbName('space')])
DrawFormattedText(w.ptr,'Time for a break!\n\nNot tired yet?','center','center',[255 255 255],100,[],[],2);
DrawFormattedText(w.ptr,'Press space to skip!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);

Screen('Flip',w.ptr)
KbStrokeWait;

RestrictKeysForKbCheck([KbName('z') KbName('m')])
end
