close all;
clear all;
clc;


fileName = 'Video_Figure_1.mov';
ourpath = 'D:\play\movie\';
obj = VideoReader(strcat(ourpath, fileName));
numFrames = obj.NumberOfFrames;% num of all the frames
Num_fras = 50;
Num_fras = numFrames;

frame1 = read(obj, 1);
frame2 = read(obj, 2);
[num1, Temp] = match_adjacent(frame1, frame2);

for i = 1 : num1
    for j = 1 : Num_fras
        Adjas{i,j} = [0 0];
        %Adjas(i,j,2) = {[0 0]};
    end
end
%coords_all = double(zeros(num1,2*numFrames));

for i = 1 : num1
    Adjas{i,1} = [Temp(i).coords1(1) Temp(i).coords1(2)];
    Adjas{i,2} = [Temp(i).coords2(1) Temp(i).coords2(2)];
end

Temp = Adjas(:,2);


%for k = 2 : Num_fras-1
for k = 2 : 3
    fprintf('*****************************************\n');
    fprintf('Handle the %d frame and the %d frame.\n', k, k+1);
    fprintf('******************************************\n');
    frame1 = read(obj, k);
    frame2 = read(obj, k+1);
    [num, Adja] = match_adjacent(frame1, frame2);
    for m = 1 : num1
        if ((Temp{m}(1) == 0) && (Temp{m}(2)== 0))
            continue;
        end

        for n = 1 : num
            if ((Temp{m}(1)==Adja(n).coords1(1)) && (Temp{m}(2)==Adja(n).coords1(2)))
                Adjas{m,k+1} = [Adja(n).coords2(1) Adja(n).coords2(2)];
            end
        end
    end
    Temp = Adjas(:,k+1);
end

save(test20160517.mat','Adjas');


% 
% % match_inds(obj, 1);
% f = fopen('coords_all_0.8.txt', 'w');
% if f == -1
%     error('Could not create file coords_all_0.8.txt.\n');
% end
% fprintf(f, '%d %d\n', num1, 2*numFrames);
% fwrite(f, Adjas', 'double');
% fclose(f);