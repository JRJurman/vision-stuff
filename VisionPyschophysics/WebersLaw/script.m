% Weber's Law in Matlab (script)
% Written by Jesse Jurman (jrj2703)

colorArray = ['g', 'm', 'b'];
kArray = [0.03, 0.05, 0.02703];
intensity = 0:2.5:50;

% build plot window, with labels
figure
title('Weber`s Law: \DeltaI = I*k || Jesse Jurman (jrj2703)');
xlabel('Stimulus Intensity (I)');
ylabel('Threshold Change (\DeltaI)');

hold on

% for each value in the kArray
kSize = size(kArray);
for index = 1:kSize(2)
    di = weber(intensity, kArray(index));
    plot(intensity, di, colorArray(index));
end

hold off