function [ ratio imgWithColour ] = colourRatio(img,colour,threshold) 
    % It calculates the ratio of a colour in an image
    % img: the image
    % colour: the three components of the colour in RGB
    % threshold: the thresdhold to be used

    [rows cols channels] = size(img);
    imgWithColourR = (img(:,:,1)>colour(1)-threshold) & (img(:,:,1)<colour(1)+threshold);
    imgWithColourG = (img(:,:,2)>colour(2)-threshold) & (img(:,:,2)<colour(2)+threshold);
    imgWithColourB = (img(:,:,3)>colour(3)-threshold) & (img(:,:,3)<colour(3)+threshold);

    imgWithColour = imgWithColourR & imgWithColourG & imgWithColourB;
    
    % opening the image
    % the optimus is disk of radius 3 (with this, in src2 incredible results)
    se = strel('disk',3);
    imgWithColour = imopen(imgWithColour,se);
    
    % applying median filter to the image
    % imgWithColour = medfilt2(imgWithColour,[8 8]);

    ratio = sum(sum(imgWithColour))/(rows*cols);
end