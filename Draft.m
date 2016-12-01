%% Main script

serieslength = 15;

target_pool

load TorontoWordPool.mat

fig = figure('units','normalized',...
    'outerposition',[0 0 1 1]);

ax = axes(fig,'xcolor',get(gcf,'color'),...
    'position', [0 0 1 1],...
    'xtick',[],...
    'ycolor',get(gcf,'color'),...
    'ytick',[]);

nword = 1;
ntrial = 0;

rng('shuffle')
while ntrial < 20
    
    
    [ppn_answer] = do_experiment(serieslength, colourlength, target);
    ntrial = ntrial + 1;
    
    data(ntrial,:) = ppn_answer;
end


while nword <= serieslength
    wordpool_h = size(wordpool, 1);
    chosen_word = randi(wordpool_h);
    str = wordpool{randi(wordpool_h)};
    
    if nword == round(stringsize/2)
    word = text(0.5, 0.5, str,...
        'fontsize', 100,...
        'Color', 'r',...
        'HorizontalAlignment', 'Center');
    else
    word = text(0.5, 0.5, str,...
        'fontsize', 100,...
        'HorizontalAlignment', 'Center');
    end
    pause(1)
    delete(word)
    wordpool{chosen_word} = [];
    nword = nword + 1;
end
close



