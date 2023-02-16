function trialMat = createTrialMatrix(coherence, trialType, trialsPerCell,practice)
getCondCode = @(trialRow) str2double(sprintf('%d%d',trialRow,practice));

switch trialType
    case "Flanker"
        % Full factorial design of Target Direction, Coherence & Congruency
        trialMat = fullfact([2 length(coherence) 2]);
        trialMat = array2table(trialMat,'VariableNames',["TargetDir","Coherence","Congruency"]);

    case "Single"
        % Full factorial design of Target Direction & Coherence
        trialMat = fullfact([2 length(coherence)]);
    trialMat = array2table(trialMat,'VariableNames',["TargetDir","Coherence"]);

end





% If this is an experimental block, add more trials.
if practice == 0
    trialMat = repmat(trialMat,trialsPerCell,1);
end



     conditionCode = arrayfun(@(K) getCondCode(table2array(trialMat(K,:))),1:height(trialMat));

         % Rename coherences
        for iCoh = 1:length(coherence)
            trialMat.Coherence(trialMat.Coherence == iCoh) = coherence(iCoh);
        end

        if strcmp(trialType,"Flanker")
        % Switch flanker direction based on congruency variable.
        trialMat.FlankerDir(trialMat.TargetDir == 1 & trialMat.Congruency == 1) = 0;
        trialMat.FlankerDir(trialMat.TargetDir == 2 & trialMat.Congruency == 1) = 180;
        trialMat.FlankerDir(trialMat.TargetDir == 1 & trialMat.Congruency == 2) = 180;
        trialMat.FlankerDir(trialMat.TargetDir == 2 & trialMat.Congruency == 2) = 0;
        end

        % Recode direction (1 = Left, 2 = Right)
        trialMat.TargetDir(trialMat.TargetDir == 1) = 0;
        trialMat.TargetDir(trialMat.TargetDir == 2) = 180;


        
% Add trial numbers and practice labels.
trialMat.CondCode = conditionCode';
trialMat = trialMat(randperm(size(trialMat, 1)), :);
trialMat = addvars(trialMat,(1:height(trialMat))','before',1,'NewVariableNames','Trial');
trialMat = addvars(trialMat,repmat(practice,height(trialMat),1),'after','Trial','NewVariableNames','Practice');