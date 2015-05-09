function result = CV_HW4_Harris_JESSE_JURMAN(filename)
    
    % read in image, turn it grayscale, that jazz
    I = imread(filename);
    Ig = rgb2gray(I);
    Ig = im2double(Ig);
    
    % build derivatives
    dx = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
    dy = dx';
    Ix = imfilter(Ig, dx, 'conv', 'same');
    Iy = imfilter(Ig, dy, 'conv', 'same');
    
    % guassian smoothing filter
    sigma = 5;
    g = fspecial('gaussian', 6*sigma, sigma);
    
    % squared edges, with guassian smoothing
    Ix2 = imfilter(Ix.^2, g, 'conv', 'same');
    Iy2 = imfilter(Iy.^2, g, 'conv', 'same');
    IxIy = imfilter(Ix .* Iy, g, 'conv', 'same');
    
    % final result
    c = (Ix2.*Iy2 - IxIy.^2)./(Ix2+Iy2);
    % oddly, some values are turned into NaN,
    % upon further inspection, these values are the far
    % left and top edge... don't know why though...
    c(isnan(c)) = 0;
    
    % debugging by showing all the values of c
    %figure, imhist(c);
    
    % extract local maxima
    radius = 20;
    size = 2*radius+1;
    
    % grayscale dilate
    mx = imdilate(c, ones(size));
    
    % find maxima
    thresh = 0.0003;
    
    cc = (c == mx)&(c>thresh);
    [r,c] = find(cc);
    
    figure, imshow(Ig)%imagesc(Ig), colormap(Ig)
    hold on
    plot(c, r, 'rs'), title('Corners')
    
end