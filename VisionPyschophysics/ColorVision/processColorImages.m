function processColorImages(rgbImageFileName)
    % The argument rgbImageFileName is a string
    
    % split the filename up
    [~, name, ~] = fileparts(rgbImageFileName);
    
    % Load the image
        % result should be saved to <rgbBaseImage>
    rgbBaseImage = imread(rgbImageFileName);
    
    % call saveOutLMS
        % arg 1 should be <rgbBaseImage>
        % arg 2 should be <rgbImageFileName> + 'RGB'
    saveOutLMS(rgbBaseImage, strcat(name, 'RGB'));
        
    % call invertRGBImage
        % arg 1 should be <rgbBaseImage>
        % arg 2 should be <rgbImageFileName>
        % result should be saved to <negativeImage>
    negativeImage = rgbToNegative(rgbBaseImage, name);
        
    % call saveOutLMS
        % arg 1 should be <negativeImage>
        % arg 2 should be <rgbImageFileName> + 'Negative'
    saveOutLMS(negativeImage, strcat(name, 'Negative'));
end