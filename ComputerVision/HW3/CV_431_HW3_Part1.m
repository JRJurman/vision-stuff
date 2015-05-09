imgs = {'Leopard1.jpg', 'Cardinal1.jpg', 'DinosaurPrints.jpg', 'BlackAndWhiteBird.jpg', 'Rock1.jpg', 'OrangeFlower.jpg'};

Images = { 0 0 0 0 0 0 };

I = imread('Leopard1.jpg');
I = rgb2gray(I);
I = I(350:950,50:650);
Images{1} = I;

I = imread('Cardinal1.jpg');
I = rgb2gray(I);
I = I(150:750,450:1050);
Images{2} = I;

I = imread('DinosaurPrints.jpg');
I = rgb2gray(I);
I = I(50:650,150:750);
Images{3} = I;

I = imread('BlackAndWhiteBird.jpg');
I = rgb2gray(I);
I = I(900:1500,900:1500);
Images{4} = I;

I = imread('Rock1.jpg');
I = rgb2gray(I);
I = I(50:350,1:300);
Images{5} = I;

I = imread('OrangeFlower.jpg');
I = rgb2gray(I);
I = I(800:1200,1400:1800);
Images{6} = I;

% No filter
%filter = 1;

% Prewitt
%filter = fspecial('prewitt');

% Sobel
%filter = fspecial('sobel');

figure;
for index = 1:6
    I = Images{index};
    
    % Using Filters
    %I = imfilter(I, filter);
    
    % Canny (different parameters)
    %I = edge(I, 'canny', []);
    
    % Laplacian (different parameters)
    I = edge(I, 'log');
    
    subplot(2, 3, index), imshow(I), title(imgs{index})
end
