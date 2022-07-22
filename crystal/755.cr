N = 10_000_000_000_000i64
# N = 1_000_000_000
a, b = 1i64, 2i64
fibs = [a, b] of Int64

while b <= N
  a, b = b, a + b
  fibs << b
end

# dp = Array(Int64).new(N + 1, 0)

# dp[0] = 1i64

# fibs.each do |f|
#   backup = dp.clone
#   (0i64..N).each do |i|
#     dp[i + f] += backup[i] if i + f <= N
#   end
# end

# sum = 0i64
# dp.map_with_index do |v, i|
#   sum += v
#   puts "#{i} => #{v} => #{sum}"
# end

fibs.pop

puts fibs.last

def f(left, top)
  return 2i64**left.size if top >= left.sum
  return 0i64 if top < 0
  path = left.clone
  v = path.shift
  f(path, top - v) + f(path, top)
end

puts f(fibs.reverse, N)