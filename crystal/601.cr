require "./lib/number_theory"
include NumberTheory

def streak(n)
  return 0 if n == 1
  # puts n
  k = 1i64
  while (n + k) % (k + 1) == 0
    # puts "#{n} #{k} #{(n + k) % (k + 1)}"
    k += 1
  end
  k
end

def p(s, n)
  (s...n).step(s).count { |i| streak(i + 1) == s }
end

# p (2..100).map { |i| streak(i) }
# p (2..100).map { |i| {i, streak(i) } }

# # puts p(3, 14)
# # puts p(6, 1_000_000)

# ans = 0i64
# (2i64..4i64**31).each do |i|
#   s = streak(i)
#   ans += 1 if i < 4i64**s
#   puts "#{i} #{s} #{ans}" if i % (4**10) == 0
# end
# # s(X) == 1 = [2, 4, 6, 8, 10, 12...]

# k =
# (2..100).each do |i|
#   puts "#{i} #{(i - 1)/k}" if streak(i) == k
# end

def lcmk(k)
  (1i128..k).reduce { |a, b| lcm(a.to_i128, b.to_i128) }
end

def p2(s, n)
  sss = (1i128..50).map { |i| lcmk(i) }.select { |l| l < n }
  cum = 0
  (s+1...sss.size).to_a.reverse.each do |k|
    l = n // sss[k - 1] - cum
    # puts "S(#{n}, #{k}) = #{l}"
    cum += l
  end
  n // sss[s - 1] - cum
end

# puts (1..31).map { |i| "#{i} #{lcmk(i)}" }.join("\n")

ans = -2i128
(1i64..31).each do |i|
  s = p2(i, 4i64**i - 1)
  ans += s
  puts "#{i} #{s} #{ans}"
end
puts ans

