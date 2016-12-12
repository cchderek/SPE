%% analysisSPE is the script for analysing recall performance
cd ./data/
files = dir('*.mat');

for ifile = 1:length(files)
    ppn_data(ifile) = load(files(ifile).name);
end

data_nTrial = size(ppn_data(1).data.ppn_wordpool,2);
data_series_length = size(ppn_data(1).data.ppn_wordpool, 1);
nPPN = length(files);

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

%% Calculate the number of correct answer per trial
for ippn = 1:length(files)
    for iRow = 1:data_nTrial
    cData(iRow,:) = double(ismember(ppn_data(ippn).data.ppn_wordpool(iRow,:), ppn_data(ippn).data.ppn_ans(iRow,:)));
    end
%% Calculate the total number of correct answer per serial position per condition
percent_correct.c(ippn,:) = sum(cData(([ppn_data(ippn).data.cLength_pool] == 0),:),1)/data_nTrial*100;
percent_correct.i(ippn,:) = sum(cData(([ppn_data(ippn).data.cLength_pool] > 1),:),1)/data_nTrial*100;
percent_correct.m(ippn,:) = sum(cData(([ppn_data(ippn).data.cLength_pool] == 1),:),1)/data_nTrial*100;

end

%% Calculate the mean values per position per condition
result.c = mean(percent_correct.c);
result.i = mean(percent_correct.i);
result.m = mean(percent_correct.m);

%% Plot the result
% Produce smooth lines
x1 = 1:.1:data_series_length;

y_c = spline(1:data_series_length,result.c,x1);
y_i = spline(1:data_series_length,result.i,x1);
y_m = spline(1:data_series_length,result.m,x1);

%% Calculate the standard error of the mean
sem_c = std(percent_correct.c)/sqrt(data_nTrial);
sem_i = std(percent_correct.i)/sqrt(data_nTrial);
sem_m = std(percent_correct.m)/sqrt(data_nTrial);

%Plot data
plot(x1,y_c, 'color', 'r');
plot(x1,y_i, 'color', 'g')
plot(x1,y_m, 'color', 'b') 
legend('control','colour (region)','colour (middle)','Location','SouthEast')

errorbar(1:size(result.c,2),result.c,sem_c, 'rx')
errorbar(1:size(result.i,2),result.i,sem_i, 'g+')
errorbar(1:size(result.m,2),result.m,sem_m, 'bo')

set(gca, 'xtick', 0:1:data_series_length,...
    'xlim', [0 data_series_length+1])
set(gca, 'ytick', 0:5:100,...
    'ylim', [0 inf])

%% Perform repeated measure two-way ANOVA

data_stat(:,1) = reshape(percent_correct.c',data_series_length*nPPN, 1);
data_stat(data_series_length*nPPN+1:2*data_series_length*nPPN,1) = reshape(percent_correct.i',data_series_length*nPPN, 1);
data_stat(2*data_series_length*nPPN+1:3*data_series_length*nPPN,1) = reshape(percent_correct.m',data_series_length*nPPN, 1);

data_stat(:,2) = repmat(repelem(1:nPPN,data_series_length),1,3)';
data_stat(:,3) = repelem(1:3,nPPN*data_series_length)';
data_stat(:,4) = repmat(1:12, 1,nPPN*3)';

FACTNAMES = {'condition', 'position'};

stats = rm_anova2(data_stat(:,1),data_stat(:,2),data_stat(:,3),data_stat(:,4),FACTNAMES);

