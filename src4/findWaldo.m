close all
clear all

load wally_dataset
load wally_net

%% PARAMETERS
imgName = '../images/11.jpg';
img = imread(imgName);
[rows cols channels] = size(img);
net = trainedNet;

STEP = 16;
X_BOX_SIZE = 100;
Y_BOX_SIZE = 250;
xHalfBox = X_BOX_SIZE/2;
yHalfBox = Y_BOX_SIZE/2;
boxedImg = img;
pointRatio = 10;
factorScale = 20;

THRESHOLD = 0.5;
 
index = [];
inputs = [];

fprintf('Finding Waldo in: %s\n\n',imgName);

% Test the neural network finding waldo in a sample image

%% PARALLEL PROCESSING
disp('PARALLEL FINDING');
[redPixels redMask] = colourRatio(img,redStripes,redThreshold);
[jeansPixels jeansMask] = colourRatio(img,jeans,jeansThreshold);
if (redPixels>=jeansPixels)
    mask = redMask;
    disp('The system attention was focused on red');
    focusedColour = ' \bfred';
else
    mask = jeansMask;
    disp('The system attention was focused on blue');
    focusedColour = ' \bfblue';
end;
disp(' ');

figure;
subplot 121
imshow(img);
title('\bfOriginal');
subplot 122
imshow(mask,'InitialMagnification',factorScale);
title(strcat('\bfFocused on',focusedColour));


%% SEQUENTIAL PROCESSING
disp('SEQUENTIAL FINDING');

total = sum(sum(mask));
for i=(1+yHalfBox):STEP:(rows-yHalfBox)
 
    for j=(1+xHalfBox):STEP:(cols-xHalfBox)
        if (mask(i,j))
            down = i-yHalfBox;
            top = i+yHalfBox;
            left = j-xHalfBox;
            right = j+xHalfBox;
            box = img(down:top,left:right,:);
            redInput = colourRatioRed(box,redStripes,redThreshold);
            jeansInput = colourRatioJeans(box,jeans,jeansThreshold);
            skinInput = colourRatioFace(box,skin,skinThreshold);
            inputs = [ inputs [redInput; jeansInput; skinInput] ];
            index = [ index [i;j] ];
        end
    end
    if sum(mask(i,:))>0
        partial = sum(sum(mask(1:i,:)));
        fprintf('inputs %d%%\n',round(partial/total*100));
    end
        
end

fprintf('net processing inputs\n');
outputs = sim(net,inputs);

fprintf('checking outputs\n');
for ii=1:length(inputs)
    out = outputs(ii);
    redRatio = inputs(1,ii);
    jeansRatio = inputs(2,ii);
    skinRatio = inputs(3,ii);
    i = index(1,ii);
    j = index(2,ii);
    
        if (out>THRESHOLD)
            fprintf('WALLY FOUND!(%i,%i) (%d%%)\t',i,j,round(out*100));
            fprintf('reds:%d%%\t jeans:%d%%\t skin:%d%%\n',round(redRatio*100),round(jeansRatio*100),round(skinRatio*100));
            down = (i-yHalfBox);
            top = (i+yHalfBox);
            left = (j-xHalfBox);
            right = (j+xHalfBox);
            box = img(down:top,left:right,:);
            boxedImg(top-2:top,left:right,:) = 0;
            boxedImg(down:down+2,left:right,:) = 0;
            boxedImg(down:top,left:left+2,:) = 0;
            boxedImg(down:top,right-2:right,:) = 0;
        end
    % fprintf('%d processed\n',(i*cols+j)/(rows*cols));
    
    % fprintf('boxed %d%%\n',round(ii/length(inputs)*100));
    % figure(fig);
    % imshow(boxedImg);
end

figure
imshow(boxedImg,'InitialMagnification',factorScale);