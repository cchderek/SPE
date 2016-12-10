%% analysisSPE is the script for analysing recall performance of a participant
%% Calculate the number of correct answer per trial
uiopen
for iRow = 1:size(data.ppn_wordpool, 1)
    cData(iRow,:) = double(ismember(data.ppn_wordpool(iRow,:), data.ppn_ans(iRow,:)));
end

data_nTrial = size(data.ppn_wordpool,2);
data_series_length = size(data.ppn_wordpool, 1);

%% Prepare figure
result_fig = figure('NumberTitle','off',...
    'Name', 'Result',...
    'Units', 'Normalized',...
    'Outerposition',[0 0 1 1],...
    'ToolBar', 'none',...
    'MenuBar','none');

title('Serial Position Effect Result', 'fontsize', 30);
xlabel('Position', 'fontsize', 20)
ylabel('Percent Correct', 'fontsize', 20)
hold on
grid on

%% Calculate the total number of correct answer per location per condition
percent_correct.c = sum(cData(([data.cLength_pool] == 0),:),1)/data_nTrial*100;
percent_correct.i = sum(cData(([data.cLength_pool] > 1),:),1)/data_nTrial*100;
percent_correct.m = sum(cData(([data.cLength_pool] == 1),:),1)/data_nTrial*100;

%% Plot the result
% Produce smooth lines
x1 = 1:.1:data_series_length;

y_c = spline(1:data_series_length,percent_correct.c,x1);
y_i = spline(1:data_series_length,percent_correct.i,x1);
y_m = spline(1:data_series_length,percent_correct.m,x1);


%Plot data
plot(x1,y_c, 'color', 'r');
hold on
plot(x1,y_i, 'color', 'g')
plot(x1,y_m, 'color', 'b') 
legend('control','colour (region)','colour (middle)','Location','SouthEast')

set(gca, 'xtick', 0:1:data_series_length,...
    'xlim', [0 data_series_length+1])
set(gca, 'ytick', 0:5:100,...
    'ylim', [-inf inf])


