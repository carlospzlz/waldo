clear all
close all

load 'wally_dataset';

%% Find optimus colours in the positive patterns
fig = figure;

for i=1:N_POSITIVE_PATTERNS
    name = strcat('../negativePatterns/',negativePatterns(i).name);
    fprintf('processing pattern: %s\t',negativePatterns(i).name);
    pattern = imread(name);
     
    [rows cols channels] = size(pattern);
     
    [ ratioRed patternRed ] = colourRatioRed(pattern,redStripes,redThreshold);
    [ ratioJeans patternJeans ] = colourRatioJeans(pattern,jeans,jeansThreshold);
    [ ratioWhite patternWhite ] = colourRatioWhite(pattern,white,skinThreshold);
    fprintf('reds=%d%%\tjeans=%d%%\tskin=%d%%\n',round(ratioRed*100), round(ratioJeans*100), round(ratioWhite*100));
    
    figure(fig);
    subplot 141
    imshow(pattern);
    title('\bfOriginal');
    subplot 142
    imshow(patternWhite);
    title(sprintf('White (%d%%)',round(ratioWhite*100)));
    subplot 143
    imshow(patternRed);
    title(sprintf('Red (%d%%)',round(ratioRed*100)));
    subplot 144
    imshow(patternJeans);
    title(sprintf('Jeans (%d%%)',round(ratioJeans*100)));
    pause(1);

end