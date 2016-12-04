%% AnalysisSPE is the script for analysing recall performance of a participant

%% Calculate the number of correct answer per trial
for iRow = 1:size(data.ppn_wordpool, 1)
    log(iRow,:) = double(ismember(data.ppn_wordpool(iRow,:), data.ppn_ans(iRow,:)));
end

%% Reallocate data per condition
analysis.analysis_c = log(([data.cLength_pool] == 0),1:size(data.ppn_wordpool,2));
analysis.analysis_i = log(([data.cLength_pool] == 1),1:size(data.ppn_wordpool,2));
analysis.analysis_1 = log(([data.cLength_pool] > 1),1:size(data.ppn_wordpool,2));

%% Calculate the total number of correct answer per location per condition
for iColumn = 1:size(data.ppn_wordpool,2)
result.logc(:,iColumn) = sum(analysis.analysis_c(:,iColumn));
result.logi(:,iColumn) = sum(analysis.analysis_i(:,iColumn));
result.log1(:,iColumn) = sum(analysis.analysis_1(:,iColumn));
end

%% Calculate the percentage of correct answer per location per condition
percent_correct.logc = result.logc/size(data.ppn_wordpool,2)*100;
percent_correct.logi = result.logi/size(data.ppn_wordpool,2)*100;
percent_correct.log1 = result.log1/size(data.ppn_wordpool,2)*100;

%% Plot the result
plot(percent_correct.logc)

hold on
plot(percent_correct.logi)
plot(percent_correct.log1)
legend('control','colour (region)','colour (middle)')


