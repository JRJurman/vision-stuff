function negImage = rgbToNegative(rgbImageIn, outFilePrefix)
    % The argument rgbImageIn is an RGB formatted image 
    % The argument outFilePrefix is a string
    % .. to be used as part of the output file name
    % This function should RETURN the color negative of your RGB image.
    
    % calculate the negative of the RGB image
    negImage = 255 - rgbImageIn;
    
    % save out the negative image
    % => outFilePrefix+"-Negative.png"
    imwrite(negImage, strcat(outFilePrefix, '-Negative.png'), 'png');
    
    % return the negative image
end