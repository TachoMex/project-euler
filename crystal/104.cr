require "big"

b = 0.to_big_i
a = 1.to_big_i

k = -1

N = 123456789.to_s

loop do
  a, b = b, a + b
  k += 1
  next unless a.to_s.size >= 9
  break if (a % 10**9).to_s.chars.sort.join == N && a.to_s[0, 9].chars.sort.join == N
end
puts k
