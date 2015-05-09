I = imread('strawberry-reference.jpg');
I = rgb2gray(I);
e = edge(I, 'canny', 0.5, 5);
se = sum(e);
se2 = sum(e');

fe = find(se);
fe2 = find(se2);

startIndex = fe(1);
endIndex = fe(end);

startIndex2 = fe2(1);
endIndex2 = fe2(end);

Ir = I;
Ir(startIndex2:endIndex2, startIndex:startIndex+5) = 255;
Ir(startIndex2:endIndex2, endIndex:endIndex+5) = 255;
Ir(startIndex2:startIndex2+5, startIndex:endIndex) = 255;
Ir(endIndex2:endIndex2+5, startIndex:endIndex) = 255;

I = cat(3, Ir, I, I);
imshow(I);