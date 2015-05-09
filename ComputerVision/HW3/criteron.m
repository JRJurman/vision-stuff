function c = criteron(vect, thresh)
    plot(vect)

    % find the important clumps of edges
    % use a moving criteron
    c = 1; s = thresh+1;
    while ( s > thresh )
        c = c + 1;
        sM = size(find(vect>c));
        s = sM(2);
    end
    sz = size(vect);
    pLine = ones(sz(2))*c;
    hold on; plot(pLine(1, :), 'red'); axis('tight'); hold off;
end