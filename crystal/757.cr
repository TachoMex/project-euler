# N = a*b = c*d
# a+b=c+d+1
# a=c+d+1-b
# b*(c+d+1-b) = c*d
# bc+bd+b-b²=c*d
# b-b²=cd-bc-bd
# b-b²=cd-b(c+d)
# b-b²+b(c+d)=cd
# b(c+d+1)-b²-cd = 0
# b(c+d+1)-b²-cd = 0
# # b(c+d+1-b)-cd = 0
# 10**6 2851
# 10**7 10908
# 10**8 40517
require "./lib/number_theory"
require "big"

# def valid(n)
#   idx = 1i64
#   sums = Hash(Int64, Tuple(Int64, Int64)).new
#   while idx * idx <= n
#     if n % idx == 0
#       other = (n/idx).to_i64
#       if sums[idx + other + 1]?
#         a, c, d, b = ([idx, other] + sums[idx+other+1].to_a).sort
#         # puts "#{n} => {#{idx}, #{other}} :: #{ tuple } :: <#{idx + other},#{idx+other+1}> #{([idx, other] + tuple.to_a).sort}"
#         return { c, d, idx, other}
#       end
#       sums[idx + other] = { idx, other }
#     end
#     idx += 1
#   end
#   false
# end

limit = 10_000_000i64
top_limit = limit * limit
# puts top_limit
count = 0
list = Set(Int64).new
halflimit = limit
max_dif = -1
max_dif2 = -2

# solutions = Set(Tuple(Int64, Int64, Int64, Int64)).new
# queue = Deque(Tuple(Int64, Int64, Int64, Int64)).new
numbers = Set(Int64).new

# def gcd(a, b)
#   b == 0 ? a : gcd(b, a % b)
# end

# def test_number(n, numbers, queue, solutions, top_limit)
#   return nil if top_limit < n
#   tuple = valid(n)
#   if tuple.is_a?(Tuple)
#     numbers << n
#     # puts tuple
#     queue << tuple
#     # solutions << tuple
#   end
# end

(1i64..limit).each do |a|
  # puts "#{a} / #{top_limit}"
  # test_number(12i64 * a, numbers, queue, solutions, top_limit)
  # test_number(a * (a + 1) * 2, numbers, queue, solutions, top_limit)
  # test_number(a * (a + 1), numbers, queue, solutions, top_limit)
  # 120 {8, 15, 10, 12} 5 3.0 2.0 a=5, r=2, c=5*3
  (1i64..a).each do |r|
    begin
      b2 = a * (r+1i64)
      c2 = a * r
      a2 = (a - 1) * r
      number = a2 * b2
      d2 = (number / c2).to_i64
      break if number > top_limit
      if number > 0 && a2+b2==c2+d2+1 && number == c2*d2
        # queue << { a2, b2, c2, d2 }
        # solutions << { a2, b2, c2, d2 }
        numbers << number
        # puts "#{number} == #{a2} * #{c2}"
      end
    rescue OverflowError
      break
    end
  end
  # next if a > top_limit
  # queue << { a, b, c, c }
  # solutions << { a, b, c, c }
  # numbers << a * b
end

# include NumberTheory
# primes, _ = sieve(limit)
# primes.each do |p|
#   a = p.to_i64
#   c = a + 1i64
#   b = 2i64 * c
#   d = 2i64 * a

#   queue << { a, b, c, c }
#   solutions << { a, b, c, c }
#   numbers << a * b
# end

# (1i64..halflimit).each do |a|
#   puts a
#   a *= a
#   top_b = Math.max(100, a * 1.1)
#   (a..top_b).each do |b|
#     break if BigInt.new(a)*b > top_limit
#     (a..b).each do |c|
#       d = a + b - c - 1
#       break if d < c
#       break if d <= 0
#       # if a*b == c*d && !list.includes?(a * b)
#       if a*b == c*d && !list.includes?(a * b)
#         count += 1
#         # puts "#{a * b} #{b - a} #{a} #{b} #{ new_max_dif } #{count}"
#         solutions << { a, b, c, d }
#         # puts (4i64..1_000i64).step(4).count { |i| valid(i) }}
#         # puts max_dif
#         list << a * b
#       end
#     end
#   end
# end

# puts "ready"

# limit = 100_000_000_000_000
# while !queue.empty?
#   p = queue.shift
#   # puts "#{queue.size} => #{p}"
#   solutions.each do |q|
#     next if p == q
#     p2 = p.map { |i| 2i64 * i }
#     a, b, c, d = p2.zip(q).map { |a, b| (a - b).abs.to_i64 }
#     tuple = { a, b, c, d }
#     if a*b == c*d && a + b == c + d + 1 && !solutions.includes?(tuple) && a>0 && b > 0 && c > 0 && d > 0 && a*b <= limit && c < d
#       modified = true
#       queue << tuple
#       solutions << tuple
#     end
#   end
# end
# kkk = solutions.size
# solv = solutions.to_a
# (0...kkk).each do |k|
#   puts "#{k}/#{kkk}"
#   p = solv[k]
#   (k+1...kkk).each do |kk|
#     q = solv[kk]
#     next if p == q
#     p2 = p.map { |i| 2i64 * i }
#     a, b, c, d = p2.zip(q).map { |a, b| (a - b).abs.to_i64 }
#     tuple = { a, b, c, d }
#     # puts tuple
#     if a*b == c*d && a + b == c + d + 1 && !solutions.includes?(tuple) && a > 0 && c > 0 && a*b <= limit && c < d
#       # queue << tuple
#       solutions << tuple
#     end
#   rescue
#     nil
#   end
# end
puts top_limit
puts numbers.size

# limit = 1_000
# count = 0
# list = Set(Int64).new
# halflimit = limit
# max_dif = -1
# max_dif2 = -2

# missing = 0

# (1i64..halflimit).each do |a|
#   max_dif = 3 if max_dif.negative?
#   new_max_dif = 0
#   (a..4*a).each do |b|
#     break if a*b > limit
#     (a..b).each do |c|
#       d = a + b - c - 1
#       break if d < c
#       break if d <= 0
#       if a*b == c*d && !numbers.includes?(a * b)
#         tuple = { a, b, c, d }
#         g = gcd(b, c)
#         puts "#{a * b} #{tuple} #{g} #{b / g} #{c / g}" if !solutions.includes?(tuple)
#         new_max_dif = Math.max((b - a)/a, new_max_dif)
#         missing += 1
#       end
#     end
#   end
#   max_dif = new_max_dif
# end

# puts "missing: #{missing}"
