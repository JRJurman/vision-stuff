I = imread('OrangeFlower.jpg');
I = rgb2gray(I);
I = I(600:1400,1200:2000);
I = im2double(I);
%figure;

subplot(2, 3, 1), imshow(I), title('Original')

filter = fspecial('prewitt');
Ip = imfilter(I, filter);
subplot(2, 3, 2), imshow(Ip), title('Prewitt Filter')

filter = fspecial('sobel');
Is = imfilter(I, filter);
subplot(2, 3, 3), imshow(Is), title('Sobel Filter')

Ic = edge(I, 'canny', [0.05 0.14], 2.8);
subplot(2, 3, 4), imshow(Ic), title('Canny Filter [0.05 0.14], 2.8')

Il = edge(I, 'log', 0.00025, 4);
subplot(2, 3, 5), imshow(Il), title('LoG Filter (0.00025, 4)')
    