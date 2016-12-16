%% runSPE is the main script of the experiment
% Format of call runSPE
% by Derek Chan and Hugo McGurran
% developed on MATLAB version 2016a/b
%% Please do not modify the following scripts %%   
    % ./data must be in the directory
%% Set up experiment
% Load the modifiable settings
settingsSPE

% Load the word pool
load TorontoWordPool.mat

% Load the GUI
GUI_SPE

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
cLength_pool(1:round(nTrial/3)) = 1;
cLength_pool(round(nTrial/3+1):round(nTrial/3*2)) = round(nTrial/3);
cLength_pool = cLength_pool(randperm(nTrial));

%% Preallocate structure for participant answer and set up break timer
data.ppn_ans(1:nTrial,1:2*series_length) = {'N/A'};
break_timer = linspace(60, 0, 61);
break_counter = 0;

%% Test trial
pause(tTrial)

tPpn_words = {'HIPPOCAMPUS','NEUROIMAGING','COGNITIVE','MATLAB','AMSTERDAM','COGNITO','STICS','BEER','SHOTS'};
tColour_words = 0;

do_experiment(tPpn_words, tColour_words, tWord)

set([ans_str1 ans_text1 ans_button1],'Visible','on');

uiwait(fig)
set([ans_str1 ans_text1 ans_button1],'Visible','off');
set(ans_text1,'String','')

%% Start experiment
for iTrial = 1:nTrial
    if break_counter == 6
       set(break_text, 'Visible','on');
        for i = 1:60
            str = num2str(break_timer(i));
            text_time = text(0.5,0.5,str,...
                'fontsize', 80);
            pause(1)
            delete(text_time)
        end
        set(break_button, 'Visible','on');
        uiwait(fig)
        set([break_button break_text], 'Visible','off');
        break_counter = 0;
    end

    pause(tTrial)

    % Get the words and the number of words in red
    ppn_words = ppn_wordpool(iTrial,:);
    colour_words = cLength_pool(iTrial);
 
    do_experiment(ppn_words,colour_words,tWord)

    %% Prompt participant for recalling the words
    set([ans_str1 ans_text1 ans_button1],'Visible','on');

    % Halt until participant confirm the answer
    uiwait(fig)
    set([ans_str1 ans_text1 ans_button1],'Visible','off');
    set(ans_text1,'String','')

    % Save the participant answer
    data.ppn_ans(iTrial,1:length(ppn_ans)) = upper(ppn_ans);

    break_counter = break_counter + 1;
end

%% Save words presented and the conditions of all trials 
data.ppn_wordpool = ppn_wordpool;
data.cLength_pool = cLength_pool';

%% Save the data
cd ./data
save(int2str(ppn),'data')
set(thk1,'Visible','on')

%% Analyse data (after collecting all the data required)
% call analysisSPE to analyse and plot all the datasets