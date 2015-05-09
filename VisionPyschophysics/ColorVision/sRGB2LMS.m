function [sRGBLMSimg] =  sRGB2LMS(sRGBfile)
% convert JPEG sRGB image to LMS and save LMS channels in a JPEG sRGB image file
% created 9/30/14 jaf

% read the sRGB image
%sRGBimg = imread(sRGBfile,'jpg');

% instead of reading the file in, take in a 3D matrix
sRGBimg = sRGBfile;

% convert sRGB 0-255 to sRGB 0-1
sRGBimg = double(sRGBimg)./255;

imgsize = size(sRGBimg);

% reshape sRGB image to sRGB pixel vector
sRGB = reshape(sRGBimg,imgsize(1)*imgsize(2),imgsize(3))';

% linearize the sRGB pixels (i.e. invert the 2.2 gamma)
sRGB=(sRGB./12.92).*(sRGB<=0.03928)+((sRGB+0.055)./1.055).^2.4.*(sRGB>0.03928);

% convert linearized sRGB 0-1 to XYZ 0-1
sRGB2XYZ=[0.4124 0.3576 0.1805;0.2126 0.7152 0.0722;0.0193 0.1192 0.9505];
XYZ = min(max(sRGB2XYZ * sRGB,0),1);

% convert XYZ 0-1 pixels to LMS 0-1
XYZ2LMS = [0.7328, 0.4296, -0.1624;-0.7036, 1.6975, 0.0061; 0.0030, 0.0136, 0.9834];
LMS = min(max(XYZ2LMS * XYZ,0),1);

% apply sRGB 2.2 gamma to the LMS values
sRGBLMS = (LMS.*12.92).*(LMS<=0.0031308) + ((1.055.*LMS).^(1/2.4)-0.055).*(LMS>0.0031308);
sRGBLMS = min(max(sRGBLMS,0),1);

% reshape sRGBLMS pixel vector back into an image
sRGBLMSimg = reshape(sRGBLMS',imgsize);

sRGBLMSimg = uint8(sRGBLMSimg.*255);