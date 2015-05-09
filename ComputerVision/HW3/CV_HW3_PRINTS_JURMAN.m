I = imread('DinosaurPrints.jpg');
I = rgb2gray(I);
I = im2double(I);
%figure;
I = imresize(I, 1/3);
figure, subplot(1, 2, 1), imshow(I);

%Ic = edge(I, 'canny', [0.20 0.25], 16);
%subplot(1,2,2), imshow(Ic), title('Canny Filter [0.20 0.25], 16')

nl = colfilt(I, [100 100], 'sliding', @findPrint);
subplot(1, 2, 2), imshow(nl, [])