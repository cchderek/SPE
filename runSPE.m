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

%% Set up counters and randomisers

% reserved for conditions counters
% reserved for control counters

%% Set up the interface and the instruction screen
fig = figure('NumberTitle','off',...
    'units','normalized',...
    'Name', 'Serial Position Effect',...
    'outerposition',[0 0 1 1]);

ax = axes(fig,'xcolor',get(gcf,'color'),...
    'position', [0 0 1 1],...
    'xtick',[],...
    'ycolor',get(gcf,'color'),...
    'ytick',[]);

% Instruction screen
str1 = sprintf('Instruction:\n\n A series of words will be presented on the screen\n\nPlease memorise as many words as possible');
inst1 = annotation(gcf,'textbox',...
    'String', str1,...
    'FontSize', 20,...
    'Position',[.3 .7 .4 .2],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle');

% 
fix = text(0.5, 0.5, '',...
    'color', 'r',...
    'fontsize', 100,...
    'Visible', 'off');

% Intertrial screen
str2 = sprintf('Press space bar to continue');
tb2 = annotation(fig,'textbox',...
    'Visible','off',...
    'String', str2,...
    'FontSize', 20,...
    'Position',[.3 .3 .4 .4],...
    'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle');

% Prompt participant for ppn
ppn_str = uicontrol(gcf,'Style','text',...
    'BackgroundColor','white',...
    'Units', 'normalized',...
    'FontSize', 30,...
    'Position',[.3 .5 .4 .1],...
    'String','Please enter your number');

ppn_text = uicontrol(gcf,'Style','edit',...
    'Units', 'normalized',...
    'FontSize', 20,...
    'Position',[.3 .4 .4 .1]);

ppn_button = uicontrol(gcf,'Style','pushbutton',...
    'Units', 'normalized',...
    'Position',[.45 .3 .1 .1],...
    'String', 'Start',...
    'FontSize', 20,...
    'Callback', 'ppn = str2double(get(ppn_text,''String'')); uiresume(gcbf)');

uiwait(fig)
validateattributes(ppn,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Participant Number',1); 

delete([ppn_str ppn_text ppn_button inst1]); 

set(fix, 'visible', 'on');
pause(1)

%%



 