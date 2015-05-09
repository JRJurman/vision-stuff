function lateralInhibition( filename, excitatoryCenter, inhibitorySurround, centerWeight )
    % Program that takes in several parameters, and returns a 2D lateral
    % ... inhibition model
    % Parameters:
    %   filename -- A string for the image filename
    %   excitatoryCenter -- The standard deviation of the excitatory 
    %        ... center of the 2D LI model (in arcmin)
    %   inhibitorySurround --  The standard deviation of the inhibitory 
    %       ... surround of the 2D LI model (in arcmin).
    %   centerWeight -- The relative weight of the excitatory center with 
    %       ... respect to the inhibitory surround
    
    % load in the image
    Image = imread(filename);
    % turn it grayscale
    ImageG = rgb2gray(Image);
    % use doubles instead of integers
    ImageG = im2double(ImageG);
    
    % calculate the visual degrees, using the current screen dimensions
    ScSz = get(0, 'ScreenSize');
    PxPerCM = get(0, 'ScreenPixelsPerInch')/2.54; % matlab's best guess
    UserDist = 60; % our best guess
    ScHeight = ScSz(4) / PxPerCM;
    
    % determine minutes of arc per pixel
    alpha = atan( (ScHeight/2) / UserDist ) * (180 / pi);
    DegPerPx = (2 * alpha) / ScSz(4);
    ArcPerPx = DegPerPx * 60;
    
    % determine pixels for standard deviation
    centerPx = excitatoryCenter/ArcPerPx;
    surroundPx = inhibitorySurround/ArcPerPx;
    
    % building excitatory gaussian
    kernSize = 3*ceil(surroundPx);
    exciteGaus = fspecial('gaussian', kernSize, centerPx);
    
    % building inhibitory gaussian
    inhibGaus = fspecial('gaussian', kernSize, surroundPx);
    
    % building difference of gaussians
    DoG = (exciteGaus*centerWeight) - inhibGaus;
    
    % apply the filter to every pixel
    ImageDoG = imfilter(ImageG, DoG);
    
    % show plots
    figure;
    subplot(2, 2, 1), imshow(Image), title('Original Image')
    subplot(2, 2, 3), imshow(ImageDoG, []), title('Modified Image')
    %subplot(2, 2, 2), imshow(DoG, []), title('Diff of Gaussian')
    subplot(2, 2, [2 4]), plot(DoG(ceil(kernSize/2), :)), title('Slice of DoG')
    hold on; plot(zeros(kernSize,1), 'black'); axis('tight'); hold off;

    % show the image on the display
    F = figure;
    %filename, excitatoryCenter, inhibitorySurround, centerWeight
    imshow(ImageDoG, []), title(sprintf('(%s, %0.2f, %0.2f, %0.2f)', filename, excitatoryCenter, inhibitorySurround, centerWeight)) ;
    
    % save the image
    [~, name, ~] = fileparts(filename); % split the file up
    saveas(F, strcat(name, 'LI2.jpg'), 'jpg');
end