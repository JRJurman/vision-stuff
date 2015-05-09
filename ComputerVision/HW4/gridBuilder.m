% build a grid
function gridBuilder(size, divisions)
    sq = ones(size);

    d = ceil(size(sq,1)/divisions);
    c = 0;
    for i = 1:d:size(sq,1)
        if mod(c, 2)==0
            sq(i:i+d, :)=0;
            sq(:, i:i+d)=0;
        end
        c = c+1;
    end
    imshow(sq);
end