close all;
clear all;
clc;

match_file = 'coords_all_0.8.txt';
len_mv = get_optimization(match_file);
fileName = 'Video_Figure_1.mov';
ourpath = 'D:\play\movie\';
obj = VideoReader(strcat(ourpath, fileName));
numFrames = obj.NumberOfFrames;% num of all the frames
frames = {};
frame = read(obj, 1);
H = size(frame,1);
W = size(frame, 2);
frames{1} = frame;
for k = 2:numFrames
    frame = read(obj, k);
    se = translate(strel(1), [round(len_mv(2*k-3)) round(len_mv(2*k-2))]);
    new_frame = imdilate(frame,se);
    %new_frame = imcrop(new_frame,[10,10,W-20,H-20]);
    frames{k} = new_frame;
end
% imshow(frame), title('Original')
% figure, imshow(new_frame), title('Translated');
% figure, imshow(frames{numFrames}), title('Test');

myObj = VideoWriter('newfile.avi');
writerObj.FrameRate = 30;
open(myObj);
for i=1:numFrames
    writeVideo(myObj,frames{i});
end 
close(myObj);