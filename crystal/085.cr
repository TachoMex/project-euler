def sum(n)
  n * (n + 1) / 2
end

def rectangles(a, b)
  sum(a) * sum(b)
end

N = 2000
K = 2_000_000
best = 100000000
best_size = { 1, 1 }

1.upto(N) do |a|
  a.upto(N) do |b|
    r = rectangles(a, b)
    if (K - r).abs < best
      best = (K - r).abs
      best_size = { a, b }
    end
    break if r > K
  end
end
puts best_size.product
