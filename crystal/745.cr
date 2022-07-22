# s(10)
# 1-1
# 2-1
# 3-1
# 4-4
# 5-1
# 6-1
# 7-1
# 8-4
# 9-9
# 10-1

# 1   -> 100 => 61
# 4   -> 25 => -5-2-1-1=16
# 9   -> 11 => 8
# 16  -> 6 => 5
# 25  -> 4 => 3
# 36  -> 2
# 49  -> 2
# 64  -> 1
# 81  -> 1
# 100 -> 1
# 69 + 16*4 + 10*9 + 3*25 + 36*2 + 64 + 81 + 100
N = 100_000_000_000_000

# squares = [] of Int32
# (1..100).each do |a|
#   squares << (1..10).map { |x| x * x }.select { |x| a % x == 0 }.max
# end

# puts squares.group_by { |x| x }.to_h { |a, b| {a, b.size} }
# puts squares.group_by { |x| x }.map { |a, b| a * b.size }
# puts squares.group_by { |x| x }.map { |a, b| a * b.size }.sum

squares = Hash(Int64, Int64).new

(1i64..N).each do |i|
  i *= i
  break if i > N
  squares[i] = (N / i).to_i64
end

# squares.keys.reverse.each do |s|
#   squares.keys.each do |other|
#     if s < other && other % s == 0
#       squares[s] -= squares[other]
#     end
#   end
# end
fixed = squares.keys.reverse.select {|t| t <= N / 4}
f_inverse = fixed.reverse
t = fixed.size
fixed.each do |s|
  break if s == 1
  f_inverse.each do |other|
    next if other == 1
    p = s * other
    break if p > N
    # puts "#{s} * #{other} = #{p}"
    squares[s] -= squares[p]
  end
end
squares.each { |k, v|  squares[1] -= v if k != 1 }



# puts fixed
# puts f_inverse
# puts squares

MOD = 1_000_000_007

puts squares.map { |k, v| (k * v) % MOD }.reduce(0) { |a, b| (a + b) % MOD}