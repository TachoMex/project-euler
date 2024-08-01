# require "./lib/heap"
require "big"
require "colorize"

# N = 1_000_003i128
N = 1_000_003i128

s = [0.to_big_i] * N


s[0] = 290797.to_big_i
(1...N).each { |i| s[i] = s[i - 1]**2 % 50515093 }
# q = Heap(BigInt, Tuple(Int32, Int32)).new

s.sort!

# (0...N-1).each do |i|
#   q.push(s[i] * s[i + 1], {i, i + 1})
# end


t = N * (N - 1) // 4 + 1

# t.times do |idx|
#   n, tuple = q.pop.unwrap
#   i, j = tuple
#   puts "#{n} #{t-idx}"
#   q.push(s[i] * s[j + 1], {i, j + 1}) if j < N - 1
# end

left = s[0] * s[1]
right = s[-1] * s[-2]

def count_less_values(s, v)
  ans = 0i128
  (0...N).each do |i|
    last = -1
    left = i
    right = N - 1
    while left <= right
      med = (left + right) // 2
      if s[i] * s[med] <= v
        left = med + 1
        last = med
      else
        right = med - 1
      end
    end
    ans += last - i if last != -1
    # (i + 1...N).each do |j|
    #   ans += 1 if s[i] * s[j] <= v
    # end
  end
  ans
end

last = -1
while left <= right
  med = (left + right) // 2
  k = count_less_values(s, med)
  # puts "#{left} #{med} => #{k}|#{t} <= #{right}".colorize(k < t ? :red : :green)
  if k == t
    last = med
    right = med - 1
  elsif k > t
    right = med - 1
  else
    left = med + 1
  end
end

puts last