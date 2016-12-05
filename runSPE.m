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
    'Units','normalized',...
    'Name','Memorise and Recall',...
    'Outerposition',[0 0 1 1]);

set(fig,'DefaulttextHorizontalAlignment','center')
set(fig,'DefaultuicontrolBackgroundColor','white')
set(fig,'DefaultuicontrolUnits','normalized')  

ax = axes(fig,'Position', [0 0 1 1],...
    'Xcolor',get(gcf,'color'),...
    'Xtick',[],...
    'Ycolor',get(gcf,'color'),...
    'Ytick',[]);

% Instruction textbox
str1 = sprintf('Instruction:\n\n A series of words will be presented on the screen\n\nPlease memorise as many words as possible');
inst1 = annotation(fig,'textbox',...
    'String',str1,...
    'FontSize',20,...
    'Position',[.3 .7 .4 .2],...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle');

% Prompt participant for participant number
ppn_str = uicontrol(gcf,'Style','text',...
    'FontSize',30,...
    'String','Please enter your number',...
    'Position',[.3 .5 .4 .1]);

ppn_text = uicontrol(gcf,'Style','edit',...
    'FontSize',20,...
    'Position',[.3 .4 .4 .1]);

ppn_button = uicontrol(gcf,'Style','pushbutton',...
    'String','Start',...
    'FontSize',20,...
    'Position',[.45 .3 .1 .1],...
    'Callback','ppn = str2double(get(ppn_text,''String'')); uiresume(gcbf)');

% Set up answer screen (hidden until the words are presented in each trial)  
ans_str1 = uicontrol('Style','text',...
    'Visible','off',...
    'String','Please recall as many words as possible in any order, separated by a space. The next trial will begin after you press confirm.',...
    'FontSize',25,...
    'Position',[.3 .5 .4 .2]);

ans_text1 = uicontrol('Style','edit',...
    'Visible','off',...
    'FontSize',20,...
    'Position',[.3 .4 .4 .1]);

ans_button1 = uicontrol('Style','pushbutton',...
    'Visible','off',...
    'String','Confirm',...
    'FontSize',20,...
    'Position',[.45 .3 .1 .1],...
    'Callback','ppn_ans = strsplit(get(ans_text1,''String'')); uiresume(gcbf)');

% Thanks Screen
str2 = sprintf('Thank You For Your Participation!');
thk1 = annotation(fig,'textbox',...
    'Visible', 'off',...
    'String',str2,...
    'FontSize',20,...
    'Position',[.3 .5 .4 .2],...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle');

% Halt the script until participant enter paricipant number
uiwait(fig)
validateattributes(ppn,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Participant Number',1); 

delete([ppn_str ppn_text ppn_button inst1]); 
%% Randomise the words presenting in the experiment and the order of trial types
rng('shuffle')
% Randomly generate the word pool from TorontoWordPool for all trials
ppn_wordpool = reshape(datasample(wordpool,series_length*nTrial,'Replace',false),nTrial,series_length);
% Randomly allocate the order of trial type (colour range & control)
cLength_pool = zeros(1,nTrial);
cLength_pool(1:nTrial/3) = 1;
cLength_pool((nTrial/3+1):nTrial/3*2) = round(nTrial/3);
cLength_pool = cLength_pool(randperm(nTrial));

ppn_data(1:20,1:20) = {'N/A'};
%% Start experiment
for iTrial = 1:nTrial
pause(2)

% Get the words and the number of words in red
ppn_words = ppn_wordpool(iTrial,:);
colour_words = cLength_pool(iTrial);
 
do_experiment(ppn_words,series_length,colour_words,tWord)

%% Prompt participant for recalling the words
set([ans_str1 ans_text1 ans_button1],'Visible','on');

% Halt until participant confirm the answer
uiwait(fig)
set([ans_str1 ans_text1 ans_button1],'Visible','off');
set(ans_text1,'String','')

% Save the participant answer
ppn_data(iTrial,1:length(ppn_ans)) = ppn_ans;

end

data.ppn_ans = upper(ppn_data);
data.ppn_wordpool = ppn_wordpool;
data.cLength_pool = cLength_pool';

%% Save the data
save(int2str(ppn),'data')
set(thk1,'Visible','on')


%% Analysis
analysisSPE