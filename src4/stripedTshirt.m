function [ similarity stripedImg mask ] = stripedTshirt(img,threshold) 
    % It calculates the ratio of a colour in an image
    % img: the image
    % colour: the three components of the colour in RGB
    % threshold: the thresdhold to be used
    redStripes = [230 120 120];
       
    [rows cols channels] = size(img);
    
    rowOffSet = round(0.2*rows);
    nRows = round(0.4*rows);
    
    if (rowOffSet+nRows>rows)
        disp('Index out of bounds');
    end
    
    region = img(rowOffSet:(rowOffSet+nRows),:,:);
    
    w = round(0.1*nRows);
    stripedImg = region;
    
    whiteRows = [1:w,2*w:3*w,4*w:5*w,6*w:7*w,8*w:9*w];
    redRows = [w:2*w,3*w:4*w,5*w:6*w,7*w:8*w,9*w:nRows];
    
    stripedImg(whiteRows,:,:) = 255;
    
    stripedImg(redRows,:,1) = redStripes(1);
    stripedImg(redRows,:,2) = redStripes(2);
    stripedImg(redRows,:,3) = redStripes(3);
    
    mask = (region>stripedImg-threshold) & (region<stripedImg+threshold);
    mask = mask(:,:,1) & mask(:,:,2) & mask(:,:,3);
    
    similarity = sum(sum(mask))/(nRows*cols);
end