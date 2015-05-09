% Given Problem
I(:,:,:) = zeros(18, 20, 3);
I(1:9,1:10,1) = 1;
I(1:9,11:20,2) = 1;
I(10:18,1:20,3) = 1;
I(10:18,11:20,2) = 1;
I(10:18,11:20,1) = 1;
Iimage = padarray(I,[10 20], 0, 'pre');
Iimage = padarray(Iimage, [5,2],'post');

% Turn Image to Gray
Igray = rgb2gray(Iimage);

% Use the sum function to add all the
% values along the Vertical and Horizontal 
VertSum = sum(Igray);
HorzSum = sum(Igray');

% Use the find function to locate all the
% non-zero indices along the Vertical and Horizontal 
VertInd = find(VertSum);
HorzInd = find(HorzSum);

% get the length and height by subtracting the last non-zero index with
% the first one (add one to account for non-zero starting index)
length = (VertInd(end) - VertInd(1)) + 1
height = (HorzInd(end) - HorzInd(1)) + 1

% Corners are found with combinations of first and last values
% along the non-zero indices of the horizontal and vertical 
UpperLHC = [HorzInd(1) VertInd(1)]
UpperRHC = [HorzInd(1) VertInd(end)]
UpperLLC = [HorzInd(end) VertInd(1)]
UpperLRC = [HorzInd(end) VertInd(end)]