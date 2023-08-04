function B = Dec2BinNumeric(D, N)
  B = rem(floor(D(:) ./ pow2(N-1:-1:0)), 2);
end