3% Open tmp.key and check its header
% g2 = fopen('tmp.txt', 'r');
% if g2 == -1
%     error('Could not open file tmp.key.');
% end
% [header, count] = fscanf(g2, '%d %d', [1 2]);
% fclose(g2);
pwd
path_img = '..\img\';
num_kp = match(strcat(path_img, '1.jpg'), strcat(path_img, '2.jpg'));
%num_kp = match('scene.pgm', 'book.pgm');

fprintf('1.jpg 2.jpg %d keypoints match.\n', num_kp);
%fprintf('box and book %d keypoint match.\n', num_kp);