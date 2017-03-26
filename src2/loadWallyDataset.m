%% properties for processing wally problem
close all
clear all

%% colours
redThreshold = 50;
redStripes = [230 120 120];
jeansThreshold = 50;
jeans = [140 175 215];
skinThreshold = 50;
skin = [255 216 147];
fprintf('skin:  (%d,%d,%d)\t threshold= %d\n',skin(1),skin(2),skin(3),skinThreshold);
fprintf('red:   (%d,%d,%d)\t threshold= %d\n',redStripes(1),redStripes(2),redStripes(3),redThreshold);
fprintf('jeans: (%d,%d,%d)\t threshold= %d\n\n',jeans(1),jeans(2),jeans(3),jeansThreshold);

%% LOADING PATTERNS
inputs = [];
outputs = [];
rationedPatterns = [];

% loading positive patterns
positivePatterns = dir('../positivePatterns/*.JPG');
positivePatterns = [ positivePatterns; dir('../positivePatterns/*.j2c') ];
[N_POSITIVE_PATTERNS row] = size(positivePatterns);

for i=1:N_POSITIVE_PATTERNS
    name = strcat('../positivePatterns/',positivePatterns(i).name);
    %fprintf('loading pattern: %s\n',name);
    pattern = imread(name);
    
    [rows cols channels] = size(pattern);
    
  
    [ ratioRed patternRed ] = colourRatioRed(pattern,redStripes,redThreshold);
    [ ratioJeans patternJeans ] = colourRatioJeans(pattern,jeans,jeansThreshold);
    [ ratioSkin patternSkin] = colourRatioFace(pattern,skin,skinThreshold);
        
    inputs = [inputs [ratioRed; ratioJeans] ];
    outputs = [outputs 1];
end
fprintf('%d positive patterns loaded\n',N_POSITIVE_PATTERNS);

% loading negative patterns
negativePatterns = dir('../negativePatterns/*.JPG');
negativePatterns = [ negativePatterns; dir('../negativePatterns/*.j2c') ];
[N_NEGATIVE_PATTERNS row] = size(negativePatterns);


for i=1:N_NEGATIVE_PATTERNS
    name = strcat('../negativePatterns/',negativePatterns(i).name);
    %fprintf('loading pattern: %s\n',name);
    pattern = imread(name);
    
    [rows cols channels] = size(pattern);
     
    [ ratioRed patternRed ] = colourRatioRed(pattern,redStripes,redThreshold);
    [ ratioJeans patternJeans ] = colourRatioJeans(pattern,jeans,jeansThreshold);
    [ ratioSkin patternSkin] = colourRatioFace(pattern,skin,skinThreshold);
        
    inputs = [inputs [ratioRed; ratioJeans] ];
    outputs = [outputs 0];
end
fprintf('%d negative patterns loaded\n',N_NEGATIVE_PATTERNS);

save('wally_dataset');

clear all