function saveOutLMS(rgbImageInName, outFilePrefix)
    % The argument rgbImageIn is an image 
    % .. with 3 channels of color data.
    % The argument outFilePrefix is a string 
    % .. to be used as part of the output file name
    
    % Convert imageIn into LMS using RGB2LMS function
    LMSImg = sRGB2LMS(rgbImageInName);
    
    % Save the S M and L components of the image into 3 grayscale images
    % => filePrefix+"-S.png", filePrefix+"-M.png", filePrefix+"-L.png"
    imwrite(LMSImg(:, :, 1), strcat(outFilePrefix, '-L.png'), 'png');
    imwrite(LMSImg(:, :, 2), strcat(outFilePrefix, '-M.png'), 'png');
    imwrite(LMSImg(:, :, 3), strcat(outFilePrefix, '-S.png'), 'png');
    
end