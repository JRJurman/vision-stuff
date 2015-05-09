I = imread('OrangeFlower.jpg');
I = rgb2gray(I);
I = im2double(I);

% A flower has lots of edges, so we'll try getting subsection with the
% highest count of edges

figure;
% apply canny filter to get edges
Ic = edge(I, 'canny', [0.01 0.09], 0.5);
subplot(2, 2, 1), imshow(Ic), title('Canny Filter [0.01 0.09], 0.5')

% use sum to get values along vert
sumVIc = sum(Ic);
% use sum to get values along horz
sumHIc = sum(Ic');

% smooth using imfilter (averaging)
fil2D = ones(50)./50;
fil1D = fil2D(1, :);
sumVIc = imfilter(sumVIc, fil1D, 0, 'same');
sumHIc = imfilter(sumHIc, fil1D, 0, 'same');

subplot(2, 2, 3);
vertC = criteron(sumVIc, 800);
title('Sum of Vert (Image-Canny)');

subplot(2, 2, 4);
horzC = criteron(sumHIc, 425);
title('Sum of Horz (Image-Canny)');

verts = find(sumVIc>vertC);
horzs = find(sumHIc>horzC);

leftEdge = verts(1);
rightEdge = verts(end);
topEdge = horzs(1);
bottomEdge = horzs(end);

I(topEdge:topEdge+15, leftEdge:rightEdge) = 1;
I(bottomEdge:bottomEdge+15, leftEdge:rightEdge) = 1;
I(topEdge:bottomEdge, leftEdge:leftEdge+15) = 1;
I(topEdge:bottomEdge, rightEdge:rightEdge+15) = 1;

%I(:, leftEdge:leftEdge+15) = 1;
%I(:, rightEdge:rightEdge+15) = 1;
%I(topEdge:topEdge+15, :) = 1;
%I(bottomEdge:bottomEdge+15, :) = 1;
subplot(2, 2, 2), imshow(I);
figure, imshow(I)