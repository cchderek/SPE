function do_experiment(ppnwords,series_length,colour_words)
% do_experiment presents the stimuli (words) for the trial
%  INPUT ppnwords = a vector of randomly generated words
%        series_length = the number of words in the trial
%        colour_words = the number of words that are coloured in red

%% Present the words serially 
for iword = 1:series_length
    str = ppnwords(iword);
    
    % Assign the colour of the word according to the conditions
    if colour_words == 1 && iword == round(series_length/2)
            word = text(0.5, 0.5, str,...
            'fontsize', 100,...
            'Color', 'r');
    elseif colour_words > 1 && iword > round(series_length/3) && iword <= round(series_length/3*2)
            word = text(0.5, 0.5, str,...
            'Color', 'r',...
            'fontsize', 100);  
    else 
            word = text(0.5, 0.5, str,...
            'fontsize', 100);           
    end
    pause(1)
    % Remove the current word
    delete(word)
end
end

