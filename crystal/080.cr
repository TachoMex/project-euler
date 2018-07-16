require "big"

def bin_search(n)
  i = BigInt.new(1)
  j = BigInt.new(n)
  best = 1.to_big_i
  best_delta = j * j
  while i <= j
    k = (i + j) / 2
    f_k = k ** 2
    delta = (n - f_k).abs
    if delta <= best_delta
      best = k
      best_delta = delta
    end
    if f_k <= n
      i = k + 1
    else
      j = k - 1
    end
  end
  best
end

def aproximate_square_root(n, d)
  bin_search(BigInt.new(n) * BigInt.new(10)**(d * 3))
end

r = (1..100).map do |i|
  if i == (i ** 0.5).to_i ** 2
    0
  else
    aproximate_square_root(i, 100).to_s[0...100].chars.map { |c| c.to_i }.sum
  end
end.sum

puts r
