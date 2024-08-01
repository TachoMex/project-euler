require "./lib/matrix"

N = 32

def factorial(n)
  return 1 if n <= 1
  (1i128..n).reduce { |a, b| a * b }
end

def comb(n, k)
  factorial(n) / factorial(k) / factorial(n - k)
end

raw = (0..N).map { |i| (0..N).map { |j| i > j ? comb(i, j)*2.0**-i : (i == j ? (i == 0 ? 1.0 : 2.0**-i - 1 ) : 0.0) } }

m = Matrix.new(raw)

r = m.inverse

r.show

vals = [-1] * (N + 1)
vals[0] = 0

puts 1.0 + vals.zip(r.raw).map { |x, row| row.sum * x }.last

# dp = [0.0] * (N + 1)

# (1..N).each do |i|
#   dp[i] = 1.0 / 2.0**(N)
#   (0...i).each do |j|
#     dp[i] += (1.0 + dp[j]) * comb(i, j).to_f64 / 2.0**(N)
#   end
# end

# pp dp
