I = imread('OrangeFlower.jpg');
Ig = rgb2gray(I);

f = [-1 0 1; -1 0 1; -1 0 1];
Im = imfilter(Ig, f, 'same');


f2 = [1 1 1; 0 0 0; -1 -1 -1];
Im2 = imfilter(Ig, f2, 'same');

figure, subplot(1, 2, 1), imshow(Im, []);
subplot(1, 2, 2), imshow(Im2, []);
