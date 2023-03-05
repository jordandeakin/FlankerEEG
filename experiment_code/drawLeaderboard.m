function drawLeaderboard(w,leaderboard,data)

if height(leaderboard) < 10
    n = height(leaderboard);
else
    n = 10;
end

DrawFormattedText2('<b><u>Leaderboard!<u><b>','win',w.ptr,'sx','center','sy',w.Yrect-500,'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
labels = {'Position','Participant ID','Reaction Time','Accuracy'};
posX = [w.Xrect-500 w.Xrect-250, w.Xrect+250 w.Xrect+500];

for i = 1:4
    DrawFormattedText2(sprintf('<color=00FFFF>%s<color>',labels{i}),'win',w.ptr,'sx',posX(i),'sy',w.Yrect-450,'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
end


posY = linspace(w.Yrect-400,w.Yrect+400,10);

for i = 1:n
    if leaderboard.ID(i) == data.demographics.ID
        DrawFormattedText2(sprintf('<b><color=00FFFF>%d<color><b>',i),'win',w.ptr,'sx',posX(1),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText2(sprintf('<b><color=00FFFF>%d<color><b>',leaderboard.ID(i)),'win',w.ptr,'sx',posX(2),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText2(sprintf('<b><color=00FFFF>%.3f<color><b>',leaderboard.RT(i)),'win',w.ptr,'sx',posX(3),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText2(sprintf('<b><color=00FFFF>%.3f<color><b>',leaderboard.Acc(i)),'win',w.ptr,'sx',posX(4),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
    else
        DrawFormattedText2(sprintf('%d',i),'win',w.ptr,'sx',posX(1),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText2(sprintf('%d',leaderboard.ID(i)),'win',w.ptr,'sx',posX(2),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText2(sprintf('%.3f',leaderboard.RT(i)),'win',w.ptr,'sx',posX(3),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);
        DrawFormattedText2(sprintf('%.3f',leaderboard.Acc(i)),'win',w.ptr,'sx',posX(4),'sy',posY(i),'xalign','center','yalign',w.Yrect-500,'xlayout','center','baseColor',[255 255 255]);

    end
end
Screen('Flip',w.ptr)
pause(10)