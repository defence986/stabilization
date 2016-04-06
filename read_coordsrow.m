clc;
% clear all;

g = fopen('coords_all_0.8.txt', 'r');
if g == -1
    error('Could not open file coords_all.txt.');
end

%[Rows,Cols] = size(coords_all);
Rows = 6363;
Cols = 690;
j = 1;
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
for i = 1 : Rows
    for j = 1 : Cols
        fprintf('%f ', Nonzero(i,j));
    end
    fprintf('\n');
end
fprintf('\n');
fprintf('************************\n');