%% Set up the interface (GUI)
%% Please do not modify the following scripts

fig = figure('NumberTitle','off',...
    'Units','normalized',...
    'Name','Memorise and Recall',...
    'Outerposition',[0 0 1 1],...
    'Toolbar', 'none',...
    'Menubar', 'none');

set(fig,'DefaulttextHorizontalAlignment','center',...
    'DefaulttextFontSize',100)
set(fig,'DefaultuicontrolBackgroundColor','white')
set(fig,'DefaultuicontrolUnits','normalized')  

ax = axes(fig,'Position', [0 0 1 1],...
    'Xcolor',get(gcf,'color'),...
    'Xtick',[],...
    'Ycolor',get(gcf,'color'),...
    'Ytick',[]);

% Instruction textbox
str1 = sprintf('Instruction:\n\n A series of words will be presented on the screen\n\nPlease memorise as many words as possible\n\n\nThe first trial is a test trial');
inst1 = annotation(fig,'textbox',...
    'String',str1,...
    'FontSize',20,...
    'Position',[.3 .65 .4 .3],...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle');

% Prompt participant for participant number
ppn_str = uicontrol(gcf,'Style','text',...
    'FontSize',30,...
    'String','Please enter your student number',...
    'Position',[.3 .5 .4 .1]);

ppn_text = uicontrol(gcf,'Style','edit',...
    'FontSize',20,...
    'Position',[.3 .4 .4 .1]);

ppn_button = uicontrol(gcf,'Style','pushbutton',...
    'String','Start',...
    'FontSize',20,...
    'Position',[.45 .3 .1 .1],...
    'Callback','ppn = str2double(get(ppn_text,''String'')); uiresume(gcbf)');


% Answer screen (hidden until the words are presented in each trial)  
str2 = sprintf('Please recall as many words as possible in any order\n\nseparated by a space\n\n\nThe next trial will begin after you press confirm.');
ans_str1 = uicontrol('Style','text',...
    'Visible','off',...
    'String',str2,...
    'FontSize',25,...
    'Position',[.2 .5 .6 .3]);

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

% Break timer and break screen
break_text = uicontrol('Style','text',...
    'Visible','off',...
    'String','Take A Break :)',...
    'FontSize',25,...
    'Position',[.3 .7 .4 .2]);

break_button = uicontrol(gcf,'Style','pushbutton',...
    'Visible','off',...
    'String','Confirm',...
    'FontSize',20,...
    'Position',[.45 .3 .1 .1],...
    'Callback','uiresume(gcbf)');

% Gratitude Screen
thk1 = annotation(fig,'textbox',...
    'Visible', 'off',...
    'String','Thank You For Your Participation!',...
    'FontSize',20,...
    'Position',[.3 .5 .4 .2],...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle');