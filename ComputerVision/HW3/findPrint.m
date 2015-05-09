function C = findPrint(x)
    w = @(x) x(2); % get number of rows
    C = ones([1 w(size(x))])./(sum(x(:)));
end