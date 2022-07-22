N = 1000

twos_for_factorials = Array(Int32).new(N + 1, 0)

(1..N).each do |n|
  i = n
  twos_for_factorials[n] += twos_for_factorials[n - 1]
  while n.even?
    twos_for_factorials[i] += 1
    n //= 2
  end
end

def bf(n, twos_for_factorials)
  (0..n).map_with_index { |i, idx| { twos_for_factorials[n] - twos_for_factorials[i] - twos_for_factorials[n - i], idx } }.max_by { |a, _| a }
end

# 14
# 389
# 7002
# 103649

# seq = [] of Int32

ans = 0
solutions = [] of Int32
(1..N).each do |i|
  y, idx = bf(i, twos_for_factorials)
  solutions << y
  ans += y
  z = s(i)
  # puts "#{i} => #{ y } #{ans}"
  puts "#{i} => #{ ans } #{z}" if z != ans
  # puts "#{i} => #{ y } <= #{idx} :: #{ans} #{ans - i}"
  # puts "#{i} #{solutions.group_by {|v| v }.to_h { |k, v|  {k, v.size} }.values }"
end

# p solutions

# puts (64..100).map { |i| x, _ = bf(i, twos_for_factorials); x }.join(' ')

# 1      1 {0 => 1}
# 2      3 {0 => 2, 1 => 1}
# 3      7 {0 => 3, 1 => 2, 2 => 2}
# 4     15 {0 => 4, 1 => 3, 2 => 4, 3 => 4}
# 5     31 {0 => 5, 1 => 4, 2 => 6, 3 => 8, 4 => 8}
# 6     63 {0 => 6, 1 => 5, 2 => 8, 3 => 12, 4 => 16, 5 => 16}
# 7    127 {0 => 7, 1 => 6, 2 => 10, 3 => 16, 4 => 24, 5 => 32, 6 => 32}
# 8    255 {0 => 8, 1 => 7, 2 => 12, 3 => 20, 4 => 32, 5 => 48, 6 => 64, 7 => 64}
# 9    511 {0 => 9, 1 => 8, 2 => 14, 3 => 24, 4 => 40, 5 => 64, 6 => 96, 7 => 128, 8 => 128}
# 10  1023 {0 => 10, 1 => 9, 2 => 16, 3 => 28, 4 => 48, 5 => 80, 6 => 128, 7 => 192, 8 => 256, 9 => 256}
# 11  2047 {0 => 11, 1 => 10, 2 => 18, 3 => 32, 4 => 56, 5 => 96, 6 => 160, 7 => 256, 8 => 384, 9 => 512, 10 => 512}
# 12  4095 {0 => 12, 1 => 11, 2 => 20, 3 => 36, 4 => 64, 5 => 112, 6 => 192, 7 => 320, 8 => 512, 9 => 768, 10 => 1024, 11 => 1024}
# 13  8191 {0 => 13, 1 => 12, 2 => 22, 3 => 40, 4 => 72, 5 => 128, 6 => 224, 7 => 384, 8 => 640, 9 => 1024, 10 => 1536, 11 => 2048, 12 => 2048}
# 14 16383 {0 => 14, 1 => 13, 2 => 24, 3 => 44, 4 => 80, 5 => 144, 6 => 256, 7 => 448, 8 => 768, 9 => 1280, 10 => 2048, 11 => 3072, 12 => 4096, 13 => 4096}
#               [14,      13,      24,      44,      80,      144,      256,      448,      768,      1280,       2048,       3072,       4096,       4096]


# 188267

# 6     63 {0 => 6, 1 => 5, 2 => 8, 3 => 12, 4 => 16, 5 => 16}
# 5 4 5 3 5 4 5 2 5 4 5 3 5 4 5 1 5 4 6
#       90 {0 => 6, 1 => 5, 2 => 9, 3 => 14, 4 => 19, 5 => 23, 6 => 13}
#      100 {0 => 6, 1 => 6, 2 => 9, 3 => 14, 4 => 21, 5 => 25, 6 => 19}
# (0...14).to_h { |i| {i, i*(i+1)} }

# puts ans
# 0 => n
# 1 => n - 1
# 2 => 2 * (n - 2)
# 3 => 4 * (n - 3)
# 4 => 8 * (n - 4)

# def f(n, k)
#   (2.0 **(k-1)).to_i64 * (n - k)
# end

def s(n, fix = 0)
  return 0 if n <= 1
  # puts (n)
  exp = Math.log(n+1, 2).to_i64
  m = 2i64 ** exp - 1
  fixture = n - m
  # puts "#{n} #{m} #{fixture}"
  # puts "#{n} => #{m}"
  # n, k = m, n - m - 1
  # (0i64..exp).map { |i| (m // (2i64**(i+2)) + 1) * (i + 1 + fix) }.reverse.zip(0i64..exp).map { |a, b| a * b }.sum + s(fixture)
  # puts "#{n} #{m} #{fixture} #{exp}"
  # puts "fixture: #{fixture} exp: #{exp}" if n == 20
  fixture_values = (0i64..exp).map do |i|
    if fixture == 0
      0
    else
      half = (fixture + 1) // 2
      fixture -= Math.min(half, fixture)
      # puts "half: #{half} new_fixture: #{fixture}" if n == 20
      half
    end
  end.reverse
  # p fixture_values if n == 20
  fixture_sum = fixture_values.reverse.zip(0i64..exp).map { |a, b| a.to_i64 * (exp - b) }.sum
  # puts "fixture_sum: #{fixture_sum}" if n == 20
  # (0i64...exp).zip((0i64...exp).map { |i| (m // (2i64**(i+2)) + 1) * (i + 1) }.reverse.zip(fixture_values).map { |a, b| a + b}).to_h#.map { |a, b| a * b }.sum
  (0i64...exp).map { |i| (m // (2i64**(i+2)) + 1) * (i + 1) }.reverse.zip(0i64...exp).map { |a, b| a.to_i64 * b }.sum + fixture_sum
end

# print("           |")
# puts (0...14).map { |i| i.to_s.ljust(6) }.join


# bits = [] of Int64
# (1..53).each do |i|
#   # print("#{i.to_s.ljust(3)}::#{(2**i - 1).to_s.ljust(6)}|")
#   sum = 0i64
#   (0...i).each do |j|
#     sum += f(i, j) * j
#     # print("#{f(i, j).to_s.ljust(5)} ")
#   end
#   bits << sum
#   # puts
# end
# p bits.map_with_index { |a, b| {a, b}}



# ans = bits.last
# i = 2i64**53 - 1
# left = (10i64**16 - i)
# puts ans + left//2 * 53 + left//4*52 + left//8*51

# puts s(16383)
# puts s(15)
# puts solutions[0...15].group_by { |v| v }.to_h { |k, v| {k, v.size} }
# puts solutions[15...20]
# puts solutions[0...20].group_by { |v| v }.to_h { |k, v| {k, v.size} }
# puts s(20)
# puts s(100)
# 14 16383
# 1  13  24  44  80  144  256  448   768  1280  2048  3072   4096  4096 ok
#     13, 24, 44, 80, 144, 256, 448, 768, 1280, 2048, 3072, 4096, 4096

# 3,  7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383

puts s(10_000_000_000_000_000)