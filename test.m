close all;
clear all;
clc;

fileName = 'Video_Figure_1.mov';
ourpath = 'D:\play\movie\'
obj = VideoReader(strcat(ourpath, fileName));
%numFrames = obj.NumberOfFrames;% num of all the frames

frame1 = read(obj, 1);
frame2 = read(obj, 2);
frame3 = read(obj, 3);

%pwd
%path_img = '..\img\';
%num_kp = match(strcat(path_img, '2.jpg'), strcat(path_img, '3.jpg'));
num_kp = match(frame1, frame2);
fprintf('First jpg second jpg %d keypoints match.\n', num_kp);
%fprintf('box and book %d keypoint match.\n', num_kp);
num_kp = match(frame2, frame3);
fprintf('Second jpg third jpg %d keypoints match.\n', num_kp);