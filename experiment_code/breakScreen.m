function breakScreen(w)
RestrictKeysForKbCheck([KbName('space')])
   DrawFormattedText2('<color=00FFFF><b>Time for a break!<color><b>\n\nNot tired yet?','win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
    DrawFormattedText(w.ptr,'Press space to skip!','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);

Screen('Flip',w.ptr)
KbStrokeWait;

RestrictKeysForKbCheck([KbName('z') KbName('m') KbName('q')])
end
