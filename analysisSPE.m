%% analysisSPE is the script for analysing recall performance of a participant
%% Calculate the number of correct answer per trial
for iRow = 1:size(data.ppn_wordpool, 1)
    cData(iRow,:) = double(ismember(data.ppn_wordpool(iRow,:), data.ppn_ans(iRow,:)));
end
%% Calculate the total number of correct answer per location per condition
percent_correct.c = sum(cData(([data.cLength_pool] == 0),:),1)/size(data.ppn_wordpool,2)*100;
percent_correct.i = sum(cData(([data.cLength_pool] == 1),:),1)/size(data.ppn_wordpool,2)*100;
percent_correct.m = sum(cData(([data.cLength_pool] > 1),:),1)/size(data.ppn_wordpool,2)*100;
%% Plot the result
plot(percent_correct.c)
hold on
plot(percent_correct.i)
plot(percent_correct.m)
legend('control','colour (region)','colour (middle)')


