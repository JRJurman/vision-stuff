I = imread('Cardinal1.jpg');
I = rgb2gray(I);
I = im2double(I);
%figure;

subplot(2, 3, 1), imshow(I), title('Original')

filter = fspecial('prewitt');
Ip = imfilter(I, filter);
subplot(2, 3, 2), imshow(Ip), title('Prewitt Filter')

filter = fspecial('sobel');
Is = imfilter(I, filter);
subplot(2, 3, 3), imshow(Is), title('Sobel Filter')

Ic = edge(I, 'canny', [0.20 0.31], 3);
subplot(2, 3, 4), imshow(Ic), title('Canny Filter [0.20 0.31], 3')

Il = edge(I, 'log', 0.00050, 4);
subplot(2, 3, 5), imshow(Il), title('LoG Filter (0.00050, 4)')
    