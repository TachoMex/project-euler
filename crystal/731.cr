require "big"
require "./lib/number_theory"

include NumberTheory

N = 1_000_000_000_000_000_0

# BigFloat.default_precision = N + 10

# def a(i)
#   BigFloat.new(3.0, N + 10)**-i * BigFloat.new(10.0, N + 10)**-(3*i -N-10)
# end

# sum = BigFloat.new

# # (1..100).each do |i|
# #   y = a(i)
# #   sum += y
# #   # sum %= 1_000_000_000_0
# #   break if y < 0.0001
# #   puts "#{i} #{y} #{sum}"
# # end

# puts sum

# MOD = 10_000_000_000

# THREE_INV = modpow(3i128, MOD - 1, MOD)

# puts THREE_INV * 3

# sum = 0i128
# sum2 = 0i128
# i = 1

# THREES = [0, 7, 67, 667, 6667, 66667, 66_666_7, 666_666_7, 666_666_67, 666_666_667].map { |i| i.to_big_i }

# loop do
#   exp = N + 10 - 3 * i
#   break if exp <= 2
#   y = (modpow(THREE_INV, i, MOD) * ((BigInt.new(10)**(exp) - 1) % MOD) % MOD)
#   mod2 = BigInt.new(10)**(exp)
#   y = (modpow(THREES[i], i.to_big_i, mod2) * 10 * ((BigInt.new(10)**(exp) - 1) % mod2) % mod2) if y > mod2
#   sum = (sum + y) % MOD
#   fy = 1.0/BigFloat.new(3.0, 1000)**i * BigFloat.new(10.0, 1000) ** exp
#   sum2 = (sum2 + fy.to_big_i) % MOD
#   puts "#{i} #{y} #{fy.to_big_i % MOD} #{exp}"

#   i += 1
# end

# puts sum % MOD
# puts sum2 % MOD


m = Math.log(N, 3).to_big_i
sum = 0.0f64
(1..m).each do |k|
  exp = N - BigInt.new(3)**k - 1
  sum += modpow(10.to_big_i, exp, 3.to_big_i**k) / 3.to_big_i**k
end
sum -= sum.to_i64
puts (sum * 10i64**10).to_i64