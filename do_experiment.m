function do_experiment(ppn_words,colour_words,tWord)
% do_experiment presents the stimuli (words) for the trial
%  INPUT ppn_words = a vector of randomly generated words
%        colour_words = the number of words that are coloured in red
%        tWord = the duration of presenting each word

%% Present the words serially 
sLength = length(ppn_words);

for iWord = 1:sLength
    str = ppn_words(iWord);
    
    % Assign the colour of the word according to the conditions
    if colour_words == 1 && iWord == round(sLength/2)
            word = text(0.5,0.5,str,... 
            'Color','r');
            
    elseif colour_words > 1 && iWord > round(sLength/3) && iWord <= round(sLength/3*2)
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

