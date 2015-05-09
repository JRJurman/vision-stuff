% script for homework one
% created by Jesse Jurman

% load and show the orange flower image
flower = imread('OrangeFlower.jpg');
figure, imshow(flower), title('Orange Flower')

% assign the green pixel plane
greenData = flower(:,:,2);
figure, imshow(greenData), title('Orange Flower Green Pixel Data')

% assign rows 1675 to 1684 and columns 975 to 984 to a variable
% and display them
im = greenData(1675:1684, 975:984);
display(im);

% assign and display the min and max values
minValue = min(im(:));
display(minValue);
maxValue = max(im(:));
display(maxValue);

% multiply each value in im by 2
im2 = 2*im;
display(im2);

% convert matrix from uint8 to double
imDouble1 = double(im);
display(imDouble1);

% multiply each value in imDouble1 by 2
imDouble12 = 2*imDouble1;
display(imDouble12);

% convert using im2double
imDouble2 = im2double(im);
display(imDouble2);

% convert to double again using mat2gray
imDouble3 = mat2gray(im);
display(imDouble3);
