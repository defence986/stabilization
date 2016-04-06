image = imread('1.jpg');
image = rgb2gray(image);
[rows, cols] = size(image);
% image2 = image';
% imshow(image);
% figure,imshow(image2);
f = fopen('test_tmp.pgm', 'w');
if f == -1
    error('Could not create file test_tmp.pgm.');
end
%fprintf(f, 'test20160330\n');
%fprintf(f, 'P5\n%d\n%d\n255\n', cols, rows);
fprintf(f, 'P5\n1280\n1280\n255\n');

fwrite(f, image', 'uint8');
fclose(f);
image2 = imread('test_tmp.pgm');
imshow(image2);