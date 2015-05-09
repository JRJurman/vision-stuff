I = imread('OrangeFlower.jpg');
I = rgb2gray(I);
I = im2double(I);

% A flower has lots of edges, so we'll try getting subsection with the
% highest count of edges

% apply canny filter to get edges
Ic = edge(I, 'canny', [0.01 0.09], 0.5);
imshow(Ic), title('Canny Filter [0.05 0.14], 2.8')