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
    
    [ ratioRed patternRed ] = colourRatioRed(pattern,redStripes,redThreshold);
    [ ratioJeans patternJeans ] = colourRatioJeans(pattern,jeans,jeansThreshold);
    [ ratioSkin patternSkin ] = colourRatioFace(pattern,skin,skinThreshold);
    [ similarity stripedImg shirtMask] = stripedTshirt(pattern,50);
    fprintf('reds=%d%%\tjeans=%d%%\tskin=%d%%\n',round(ratioRed*100), round(ratioJeans*100), round(ratioSkin*100));
    
    figure(fig);
    subplot 161
    imshow(pattern);
    title('\bfOriginal');
    subplot 162
    imshow(patternSkin);
    title(sprintf('Face (%d%%)',round(ratioSkin*100)));
    subplot 163
    imshow(patternRed);
    title(sprintf('Red (%d%%)',round(ratioRed*100)));
    subplot 164
    imshow(patternJeans);
    title(sprintf('Jeans (%d%%)',round(ratioJeans*100)));
    subplot 165
    imshow(stripedImg);
    title('red&white stripes');
    subplot 166
    imshow(shirtMask*100);
    title(sprintf('¿Striped t-shirt? (%d%%)',round(similarity*100)));
    pause(1);

end