function endTask(w,trialSequence)

idx = trialSequence.Practice == 0;
averageAcc = mean(trialSequence.Correct(idx))*100;
averageRT = median(trialSequence.RT(idx))*1000;

text = sprintf('You''ve reached the end of this task!\n You responded correctly on <color=00FFFF>%.2f%%<color> of trials.\nYour average response time was <color=00FFFF>%.2fms<color>.\n\n \n\nThank you for your participation.',averageAcc,averageRT);
DrawFormattedText2(text,'win',w.ptr,'sx','center','sy','center','xalign','center','yalign','center','xlayout','center','baseColor',[255 255 255]);
DrawFormattedText(w.ptr,'Press any key to finish this part of the experiment.','center',w.Yrect+300,[0 255 255],100,[],[],2);%'baseColor',[255 255 255]);

    Screen('Flip',w.ptr);
    KbStrokeWait; 
end