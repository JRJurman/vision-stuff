function CV_HW2_Jurman( img, E, m, low_in, high_in, low_out, high_out, nlev )
    %CV_HW2_Jurman - Homework Assignment 2
    % img - the color image passed to the function
    % E, m - parameters for the contrast stretching equation
    % low_in, high_in, low_out, high_out - imadjust Matlab parameters
    % nlev - histogram equalization parameters
    
    g_img = rgb2gray(img);
    
    % Process the image img using the contrast stretching
    % equation taken from slides;  T(r) = 1 / 1 + ( m / r )^E
    img_cs = 1./(1+(m./(double(g_img)+eps)).^E);

    % Process the image img using imadjust
    img_ima = imadjust(g_img, [low_in high_in], [low_out high_out]);

    % Process the image img using Matlab's histogram equalization function
    % with nlev
    img_hseq = histeq(g_img, nlev);

    % Using the subplot function display the original image the the four 
    % processed images in a 2 x 2 grid
    figure
    subplot(2, 2, 1), imshow(g_img), title('Original')
    subplot(2, 2, 2), imshow(img_cs), title('Contrast Stretching')
    subplot(2, 2, 3), imshow(img_ima), title('Image Adjust')
    subplot(2, 2, 4), imshow(img_hseq), title('Histogram Equalization')

end
