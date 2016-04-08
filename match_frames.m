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
fprintf(f, '%d %d\n', num1, 2*numFrames);
fwrite(f, coords_all', 'double');
fclose(f);