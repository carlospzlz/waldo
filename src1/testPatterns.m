clear all
close all

load 'wally_dataset';

%% Find optimus colours in the positive patterns
fig = figure;

for i=1:N_POSITIVE_PATTERNS
    name = strcat('../positivePatterns/',positivePatterns(i).name);
    fprintf('processing pattern: %s\t',positivePatterns(i).name);
    pattern = imread(name);
    
    [rows cols channels] = size(pattern);
    
    [ ratioRed patternRed ] = colourRatio(pattern,redStripes,redThreshold);
    [ ratioJeans patternJeans ] = colourRatio(pattern,jeans,jeansThreshold);
    [ ratioSkin patternSkin ] = colourRatio(pattern,skin,skinThreshold);
    fprintf('reds=%d%%\tjeans=%d%%\tskin=%d%%\n',round(ratioRed*100), round(ratioJeans*100), round(ratioSkin*100));
    
    figure(fig);
    subplot 141
    imshow(pattern);
    title('\bfOriginal');
    subplot 142
    imshow(patternSkin);
    title(sprintf('Face (%d%%)',round(ratioSkin*100)));
    subplot 143
    imshow(patternRed);
    title(sprintf('Red (%d%%)',round(ratioRed*100)));
    subplot 144
    imshow(patternJeans);
    title(sprintf('Jeans (%d%%)',round(ratioJeans*100)));
    pause(1);

end