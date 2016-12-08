%% analysisSPE is the script for analysing recall performance of a participant
cd ./data/
files = dir('*.mat');
for ifile = 1:length(files)
    ppn_data(ifile) = load(files(ifile).name);
end

%% Calculate the number of correct answer per trial
for ippn = 1:length(files)
    for iRow = 1:size(ppn_data(ippn).data.ppn_wordpool, 1)
    cData(iRow,:) = double(ismember(ppn_data(ippn).data.ppn_wordpool(iRow,:), ppn_data(ippn).data.ppn_ans(iRow,:)));
    end
%% Calculate the total number of correct answer per location per condition
percent_correct.c(ippn,:) = sum(cData(([ppn_data(ippn).data.cLength_pool] == 0),:),1)/size(ppn_data(ippn).data.ppn_wordpool,2)*100;
percent_correct.i(ippn,:) = sum(cData(([ppn_data(ippn).data.cLength_pool] == 1),:),1)/size(ppn_data(ippn).data.ppn_wordpool,2)*100;
percent_correct.m(ippn,:) = sum(cData(([ppn_data(ippn).data.cLength_pool] > 1),:),1)/size(ppn_data(ippn).data.ppn_wordpool,2)*100;

end

%% Calculate the mean values per position per condition
result.c = mean(percent_correct.c);
result.i = mean(percent_correct.i);
result.m = mean(percent_correct.m);

%% Plot the result
% Produce smooth lines
x1 = 1:.1:12;

y_c = spline(1:size(result.c,2),result.c,x1);
y_i = spline(1:size(result.i,2),result.i,x1);
y_m = spline(1:size(result.m,2),result.m,x1);


result_fig = figure('NumberTitle','off',...
    'Name', 'Result',...
    'Units', 'Normalized',...
    'Outerposition',[0 0 1 1]);

% Plot data
plot(x1,y_c, 'color', 'r');
hold on
plot(x1,y_i, 'color', 'g')
plot(x1,y_m, 'color', 'b')

set(gca, 'xlim', [1 12])
set(gca, 'ylim', [0 inf])
legend('control','colour (region)','colour (middle)','Location','SouthEast')

%{
% Ugly lines
line(1:size(result.c,2),result.c,'color','r')

line(1:size(result.i,2),result.i,'color','g')

line(1:size(result.m,2),result.m,'color','b')

legend('control','colour (region)','colour (middle)')
%}