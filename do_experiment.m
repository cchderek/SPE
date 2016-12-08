function do_experiment(ppn_words,series_length,colour_words,tWord)
% do_experiment presents the stimuli (words) for the trial
%  INPUT ppn_words = a vector of randomly generated words
%        series_length = the number of words in the trial
%        colour_words = the number of words that are coloured in red
%        tWord = the duration of presenting each word

%% Present the words serially 
for iWord = 1:series_length
    str = ppn_words(iWord);
    
    % Assign the colour of the word according to the conditions
    if colour_words == 1 && iWord == round(series_length/2)
            word = text(0.5,0.5,str,... 
            'Color','r');
            
    elseif colour_words > 1 && iWord > round(series_length/3) && iWord <= round(series_length/3*2)
            word = text(0.5,0.5,str,...
            'Color','r');  
    else 
            word = text(0.5,0.5,str);           
    end
    pause(tWord)
    % Remove the current word
    delete(word)
end
end

