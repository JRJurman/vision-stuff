I = imread('Cardinal1.jpg');
I = rgb2gray(I);
Ic = I(150:750,450:1050);
Ic = im2double(Ic);

canny = edge(Ic, 'canny');
Ic = Ic.*(canny+0.1);

imshow(Ic);