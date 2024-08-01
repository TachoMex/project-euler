N = 100_000
rad = Array(Int128).new(N + 1, 1)
(2i128..N).each do |i|
  if rad[i] == 1
    (i..N).step(i).each do |j|
      rad[j] *= i
    end
  end
end

ans = rad.map_with_index { |r, idx| {r, idx} }.sort do |a, b|
  ar, ai = a
  br, bi = b
  ar == br ? ai <=> bi : ar <=> br
end

puts ans[10000]
