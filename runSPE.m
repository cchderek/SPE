%% runSPE is the main script of the experiment
% Format of call runSPE
% by Derek Chan and Hugo McGurran
% developed on MATLAB version 2016a/b

%% Please do not modify the following scripts %%   
%% Set up experiment
% Load the modifiable settings
settingsSPE

% Load the word pool
load TorontoWordPool.mat

%% Set up the interface (GUI)
fig = figure('NumberTitle','off',...
    'units','normalized',...
    'Name', 'Memorise and Recall',...
    'outerposition',[0 0 1 1]);

set(fig,'defaulttexthorizontalalignment', 'center')
set(gcf, 'defaultuicontrolBackgroundColor','white')

ax = axes(fig,'xcolor',get(gcf,'color'),...
    'position', [0 0 1 1],...
    'xtick',[],...
    'ycolor',get(gcf,'color'),...
    'ytick',[]);

% Instruction textbox
str1 = sprintf('Instruction:\n\n A series of words will be presented on the screen\n\nPlease memorise as many words as possible');
inst1 = annotation(fig,'textbox',...
    'String', str1,...
    'FontSize', 20,...
    'Position',[.3 .7 .4 .2],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle');

% Prompt participant for participant number
set(fig,'Defaultuicontrolunits','normalized')  
ppn_str = uicontrol(gcf,'Style','text',...
    'FontSize', 30,...
    'Position',[.3 .5 .4 .1],...
    'String','Please enter your number');

ppn_text = uicontrol(gcf,'Style','edit',...
    'FontSize', 20,...
    'Position',[.3 .4 .4 .1]);

ppn_button = uicontrol(gcf,'Style','pushbutton',...
    'Position',[.45 .3 .1 .1],...
    'String', 'Start',...
    'FontSize', 20,...
    'Callback', 'ppn = str2double(get(ppn_text,''String'')); uiresume(gcbf)');

% Set up answer screen (hidden until the words are presented in each trial)  
ans_str1 = uicontrol('Style','text',...
    'Visible', 'off',...
    'FontSize', 25,...
    'Position',[.3 .5 .4 .2],...
    'String','Please recall as many words as possible in any order, separated by a space. The next trial will begin after you press confirm.');

ans_text1 = uicontrol('Style','edit',...
    'Visible', 'off',...
    'FontSize', 20,...
    'Position',[.3 .4 .4 .1]);

ans_button1 = uicontrol('Style','pushbutton',...
    'Visible', 'off',...
    'FontSize', 20,...
    'String', 'Confirm',...
    'Position',[.45 .3 .1 .1],...
    'Callback', 'ppn_ans = strsplit(get(ans_text1,''String'')); uiresume(gcbf)');

% Halt the script until participant enter paricipant number
uiwait(fig)
validateattributes(ppn,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Participant Number',1); 

delete([ppn_str ppn_text ppn_button inst1]); 
%% Randomise the words presenting in the experiment and the order of trial types
rng('shuffle')
% Randomly generate the word pool from TorontoWordPool for all trials
ppn_wordpool = reshape(datasample(wordpool, series_length*nTrial), nTrial, series_length);
% Randomly allocate the order of trial type (colour range & control)
clength_pool = zeros(1,series_length);
clength_pool(1:series_length/3) = 1;
clength_pool((series_length/3+1):series_length/3*2) = round(series_length/3);
clength_pool = clength_pool(randperm(series_length));

%% Start experiment
for itrial = 1:nTrial
pause(2)

% Get the words and the number of words in red
ppnwords = ppn_wordpool(itrial,:);
colour_words = clength_pool(itrial);
 
do_experiment (ppnwords, series_length, colour_words)

%% Prompt participant for recalling the words
set([ans_str1 ans_text1 ans_button1], 'visible', 'on');

% Halt until participant confirm the answer
uiwait(fig)
set([ans_str1 ans_text1 ans_button1], 'visible', 'off');
set(ans_text1,'String','')

% Save the participant answer
data(itrial,1:length(ppn_ans)) = ppn_ans;
end

close all

%% Save the data
filename = int2str(ppn);
save(filename, 'data')
msgbox('Thank you for your participation!')

