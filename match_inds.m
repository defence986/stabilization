function match_inds(obj, k)

frame1 = read(obj, k);
frame2 = read(obj, k+1);
[num, match] = match_adj(frame1, frame2);
for i = 1 : length(match)
    if match(i) > 0
        match_inds(obj, k);
    end
    if 
    ind_link(1) == i;
    fprintf(f, '%d\n', match(i));
end