close all;
clear all;
clc;

%delete('..\temp\*.jpg');

%fileName = 'Betrayed Innocence.avi'; 
%fileName = 'cat and mouse.avi';
fileName = 'Video_Figure_1.mov';
ourpath = 'D:\play\movie\'
obj = VideoReader(strcat(ourpath, fileName));
numFrames = obj.NumberOfFrames;% num of all the frames

frame1 = read(obj, 1);
frame2 = read(obj, 2);
[num1, Temp] = match_adj(frame1, frame2);
coords_all = double(zeros(num1,2*numFrames));
coords_all(:,1:4) = Temp(:,:);
Temp = coords_all(:,3:4);

for k = 2 : numFrames-1
%for k = 2 : 3
    fprintf('*****************************************\n');
    fprintf('Handle the %d frame and the %d frame.\n', k, k+1);
    fprintf('******************************************\n');
    frame1 = read(obj, k);
    frame2 = read(obj, k+1);
    [num, coords_adj] = match_adj(frame1, frame2);
    for m = 1 : num1
        if Temp(m,1) ~= 0
            for n = 1 : num
                if (Temp(m,1)==coords_adj(n,1)) && (Temp(m,2)==coords_adj(n,2))
                    coords_all(m,(2*k+1)) = coords_adj(n,3);
                    coords_all(m,(2*k+2)) = coords_adj(n,4);
                end
            end
        end
    end
    Temp = coords_all(:,(2*k+1):(2*k+2));
end        
        
% match_inds(obj, 1);
f = fopen('coords_all_0.8.txt', 'w');
if f == -1
    error('Could not create file coords_all_0.8.txt.\n');
end
fwrite(f, coords_all', 'double');
fclose(f);

if 0
for k = 1 : numFrames-1
    frame1 = read(obj, k);
    frame2 = read(obj, k+1);
    
    img1 = strcat('..\temp\', num2str(k),'.jpg');
    img2 = strcat('..\temp\', num2str(k+1),'.jpg');
    %imshow(frame);
    imwrite(frame1,img1,'jpg');% 保存帧
    imwrite(frame2,img2,'jpg');
    [num, match_adj] = match_adj(img1, img2);
    if num == 0
        error('%d frame and %d frame has 0 same keypoint.\n', k, k+1);
    else
        fprintf('%d frame and %d frame has %d same keypoints.\n', k, k+1, num);
        fprintf('********************************************\n');
    end    
end
end

%imshow('666.jpg');
% if 0
% for k = 1 : numFrames -1
%     ima = imread(strcat(num2str(k),'.jpg'));
%     ima2 = imread(strcat(num2str(k+1),'.jpg'));
%     ima_f = fft2(ima);
%     ima_f2 = fft2(ima2);
%     frame_f = (ima_f + ima_f2) / 2;
%     frame = ifft(frame_f);
%     imwrite(frame,strcat(num2str(k),'_',num2str(k),'.jpg'),'jpg');
% end
% end

% ima = imread('1.jpg');
% ima_g = rgb2gray(ima);
% ima_f = fft2(ima_g);
% ima2 = ifft2(ima_f);
% imshow(ima_g);
% figure,imshow(ima2);
    %ima_g = rgb2gray(ima);
%ima_f = rgb2gray(f);
%[M, N] = size(f);
% whos f
% imshow(f);
% M
%f(15, :)

%F
%FP = sqrt(real(F).^2 + imag(F).^2);
%mod_ima = abs(ima_f);
%Image=log(1+double(fftshift(FP))); 
%figure(1), imshow(f); title('原图')
%figure(2); imshow(FP); title('傅立叶变换')
%figure(3); imshow(fftshift(FP)); title('中心平移')
%figure(4);imshow(Image,[]); title('中心平移后取对数')
%threeD_mod_ima_log = log2(mod_ima) + 1;
%[x1,y1] = size(threeD_mod_ima_log);
%[a1,b1]=meshgrid(1:x1,1:y1);
%surf(X, Y, FP);
%i = 0 : H;
%j = 0 : V;
%plot3(i, j, FP);
%FP(1, 1)
%figure,subplot(1,2,1),mesh(a1,b1,threeD_mod_ima_log);
%figure,subplot(1,2,1),mesh(threeD_mod_ima_log);
%shading interp;          % 在网格片内采用颜色插值处理，使得三维表面图显得光滑
%title('输入图像的三维傅里叶幅度谱');