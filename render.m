clc;

%delete('..\temp\*.jpg');

%fileName = 'Betrayed Innocence.avi'; 
%fileName = 'cat and mouse.avi';
fileName = 'Video_Figure_1.mov';
ourpath = 'D:\play\movie\'
obj = VideoReader(strcat(ourpath, fileName));
%numFrames = obj.NumberOfFrames;% num of all the frames

k = 1;
frame1 = read(obj, k);
frame2 = read(obj, k+1);
%[num1, Temp] = match_adj(frame1, frame2);
num1 = match_render(frame1, frame2);

