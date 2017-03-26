function [ ratio imgWithColour ] = colourRatioFace(img,colour,threshold) 
    % It calculates the ratio of a colour in an image
    % img: the image
    % colour: the three components of the colour in RGB
    % threshold: the thresdhold to be used
    
    [rows cols channels] = size(img);
    
    rowOffSet = 1;
    nRows = round(0.3*rows);
    
    if (rowOffSet+nRows>rows)
        disp('Index out of bounds');
    end
    
    region = img(rowOffSet:(rowOffSet+nRows),:,:);
    [ratio imgWithColour] = colourRatio(region,colour,threshold);
end