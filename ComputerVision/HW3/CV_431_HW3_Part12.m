I = imread('Rock1.jpg');
I = rgb2gray(I);
I = im2double(I);
I = I(50:350,1:300);
figure;

%subplot(3, 4, 1), imshow(I), title('Original')
for index = 1:15
    % Using Filters
    %I = imfilter(I, filter);
    
    % Canny (different parameters)
    lt = 0.1 + index*0.05;
    ht = 0.50;
    sig = index*0.5;
    Ic = I.*( edge(I, 'log', lt, 0.5) + 0.2 );
    % Laplacian (different parameters)
    
    subplot(3, 5, index), imshow(Ic), title(sprintf('%0.2f',lt));
end
