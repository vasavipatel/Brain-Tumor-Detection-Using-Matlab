close all;
clear all;
clc;

% Prompt user to select a brain image file
[filename, pathname] = uigetfile({'*.png;*.jpg;*.jpeg;*.bmp', 'Image files (*.png, *.jpg, *.jpeg, *.bmp)'}, 'Select Brain Image');
if isequal(filename, 0) || isequal(pathname, 0)
    disp('User canceled the operation. Exiting...');
    return;
end

% Read the selected brain image
img = imread(fullfile(pathname, filename));

% Your existing code starts from here
bw = im2bw(img, 0.7);
label = bwlabel(bw);
stats = regionprops(label, 'Solidity', 'Area');
density = [stats.Solidity];
area = [stats.Area];
high_dense_area = density > 0.5;
max_area = max(area(high_dense_area));
tumor_label = find(area == max_area);
tumor = ismember(label, tumor_label);
se = strel('square', 5);

tumor = imdilate(tumor, se);

figure(2);
subplot(1, 3, 1);
imshow(img, []);
title('Brain');

subplot(1, 3, 2);
imshow(tumor, []);
title('Tumor Alone');

[B, L] = bwboundaries(tumor, 'noholes');
subplot(1, 3, 3);
imshow(img, []);
hold on
for i = 1:length(B)
    plot(B{i}(:, 2), B{i}(:, 1), 'y', 'linewidth', 1.45);
end

title('Detected Tumor');
hold off;
