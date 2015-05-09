% print original images
g_log = rgb2gray(imread('DarkLog.jpg'));
g_tree = rgb2gray(imread('DarkTree.jpg'));

% figure, subplot(1, 2, 1), imshow(g_log), title('DarkLog.jpg (grayscale)')
% subplot(1, 2, 2), imshow(g_tree), title('DarkTree.jpg (grayscale)')
I = g_tree;

% figure
for m=3:1:8
    for E=1:1:5
%        img_cs = 1./(1+(m./(double(I))).^E);
%        subplot(6, 5, ((m-3)*5)+E), imshow(img_cs), title(sprintf('m = %d, E = %d', m, E))
    end
end

%figure
counter = 0;
counter2 = 0;
for li=0:0.05:0.3
    for hi=li+0.05:0.05:0.2
        img_ima = imadjust(I, [li hi+0.001], [0 1]);
        counter = counter + 1;
        index =counter;
%        subplot(5, 5, index), imshow(img_ima), title(sprintf('LowIn = %0.2f, HighIn = %0.2f', li, hi))
    end
    counter2 = counter2 + 1;
    counter = counter2*5 + counter2;
end

figure
for nlev=5:5:100
    img_hist = histeq(I, nlev);
    subplot(5, 5, (nlev/5)), imshow(img_hist), title(sprintf('nlev = %0.1f', nlev))
end