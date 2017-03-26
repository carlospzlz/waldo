function [ ratio imgWithColour ] = colourRatioJeans(img,colour,threshold) 
    % It calculates the ratio of a colour in an image
    % img: the image
    % colour: the three components of the colour in RGB
    % threshold: the thresdhold to be used
      
    [rows cols channels] = size(img);
    
    rowOffSet = round(0.5*rows);
    nRows = floor(0.5*rows);
    
    if (rowOffSet+nRows>rows)
        disp('Index out of bounds');
    end
    
    region = img(rowOffSet:(rowOffSet+nRows),:,:);    
    [ratio imgWithColour] = colourRatio(region,colour,threshold);
end