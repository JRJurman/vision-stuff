R = rand(16);
n = R.*R;
m = sqrt(R);

figure, subplot(1,3,1), imshow(R), title('Original')
subplot(1,3,2), imshow(n), title('N')
subplot(1,3,3), imshow(m), title('M')

