I = imread('BlackAndWhiteBird.jpg');
I = rgb2gray(I);
I = I(800:1800,800:1800);
I = im2double(I);
%figure;

subplot(2, 3, 1), imshow(I), title('Original')

filter = fspecial('prewitt');
Ip = imfilter(I, filter);
subplot(2, 3, 2), imshow(Ip), title('Prewitt Filter')

filter = fspecial('sobel');
Is = imfilter(I, filter);
subplot(2, 3, 3), imshow(Is), title('Sobel Filter')

Ic = edge(I, 'canny', [0.20 0.25], 16);
subplot(2, 3, 4), imshow(Ic), title('Canny Filter [0.20 0.25], 16')

Il = edge(I, 'log', 0.000055, 10);
subplot(2, 3, 5), imshow(Il), title('LoG Filter (0.000055, 10)')
    