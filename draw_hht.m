close all;
clear all;
clc;
% clear all;

% read_coordsrow
g = fopen('coords_all_0.8.txt', 'r');
if g == -1
    error('Could not open file coords_all.txt.');
end

j = 1;

if 0
while ~feof(g)
    Rows = Rows+sum(fread(g,10000,'*char')==char(10));
end
end

[coords_row,counts] = fscanf(g, '%d %d', [1 2]);
if (counts ~= 2)
    error('Invalid coords first row.');
end
Rows = coords_row(1);
Cols = coords_row(2);

fseek(g,9,'bof');
for i = 1 : Rows
    [coords_row, counts] = fread(g, [1 Cols], 'double');
    if (counts ~= Cols)
        error('Invalid coords row value.');
    end
    if (coords_row(Cols) == 0)
        continue;
    end
    Nonzero(j,:) = coords_row(:);
    j = j + 1;
end
fclose(g);

fprintf('************************\n');
[Rows,Cols] = size(Nonzero);
%Rows
%Cols
%Nonzero(1,1)
for i = 1 : Rows
    for j = 1 : Cols
        fprintf('%f ', Nonzero(i,j));
    end
    fprintf('\n');
end
fprintf('\n');
fprintf('************************\n');

Cols = Cols - 2;
for i = 1 : Rows
    for j = 1 : Cols
        Dists(i,j) = Nonzero(i,j) - Nonzero(i,j+2);
    end
end

fprintf('************************\n');
for i = 1 : Rows
    for j = 1 : Cols
        fprintf('%f ', Dists(i,j));
    end
    fprintf('\n');
end
fprintf('\n');
fprintf('************************\n');

Cols = Cols / 2;
for i = 1 : Rows
    for j = 1 : Cols
        Dist(i,j) = sqrt(Dists(i,2*j-1).^2 + Dists(i,2*j).^2);
    end
end

[vars,indx] = sort(std(Dist, 0, 2));
Trace =Dist(indx(1), :);
plot(Trace);

Fs = 30;
plot_hht(Trace,1/Fs);