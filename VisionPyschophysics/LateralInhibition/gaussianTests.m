function gaussianTests(filename)
    G1 = fspecial('gaussian', 32, 10);
    G2 = fspecial('gaussian', 32, 4);
    DoG = G2 - G1;
    figure;
    subplot(2, 2, 1), imshow(DoG, []);
    title('Difference of Gaussian');

    subplot(2, 2, 3), plot(DoG(16,:)), title('Slice of DoG');
    hold on; plot(zeros(32,1), 'black'); axis('tight'); hold off;

    Im = imread(filename);
    subplot(2, 2, 2), imshow(Im), title('Original Image');

    Ig = rgb2gray(Im);
    Idouble = im2double(Ig);
    Idog = imfilter(Idouble, DoG);

    subplot(2, 2, 4), imshow(Idog>0.13, []);
    title('Difference of Gaussians (Enhanced)');

    %figure, imshow(Idog, []);
    %title('Difference of Gaussians (Doubles)');
end