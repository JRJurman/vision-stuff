function result = CV_HW4_Correlation_JESSE_JURMAN(filename, patch_size, start_row, start_column)
    %example usage:
    %   CV_HW4_Correlation_JESSE_JURMAN('OrangeFlower.jpg', [500 200], 600, 1000)
    %   CV_HW4_Correlation_JESSE_JURMAN('OrangeFlower.jpg', [200 200], 800, 1300)
    %   CV_HW4_Correlation_JESSE_JURMAN('OrangeFlower.jpg', [800 800], 800, 1300)
    
    % read in image, turn it grayscale, that jazz
    I = imread(filename);
    Ig = rgb2gray(I);
    Ig = im2double(Ig);
    figure, subplot(3, 2, 1), imshow(Ig), title('image');
    
    if nargin < 4
        start_column = ceil(size(Ig, 2)/2);
    end
    
    % get a patch using the given parameters
    rows = patch_size(1);
    columns = patch_size(2);
    patch = Ig(start_row:start_row+rows, start_column:start_column+columns);
    subplot(3, 2, 2), imshow(patch), title('patch');
    
    % create a strip using the patch size and position
    strip = Ig(start_row:start_row+rows, 1:end);
    subplot(3, 2, 3:4), imshow(strip), title('strip');
    
    % use the normxcorr2 with the patch and strip to generate the Cross
    % Correlation matrix
    resMatrix = normxcorr2(patch, strip);
    resPlot = resMatrix(ceil(size(resMatrix, 1)/2), :);
    resPlot = abs(1 - resPlot);
    subplot(3, 2, 5:6), plot(resPlot), axis('tight'), title('Cross Correlation Plot');
    
    result = resPlot;
end