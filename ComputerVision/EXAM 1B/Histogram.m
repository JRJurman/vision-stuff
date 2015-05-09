function in = Histogram(h, g)
    minHG = min(h,g)
    sumMINHG = sum(minHG)
    sumH = sum(h)
    sumG = sum(g)
    minSUM = min( sumH, sumG )
    in = sumMINHG / minSUM
end