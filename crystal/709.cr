require "big"

MOD = 1020202009

def pow(a, b, c)
  if b == 0 || a == 1
    1
  elsif b == 1
    a
  else
    h = b // 2
    t = pow(a, h, c)
    t * t % c * pow(a, b % 2, c) % c
  end
end

def inv(a, p)
  pow(a, p - 2, p)
end

FACTORIALS = (1i64..25000i64).each_with_object(Array(BigInt).new(25010) { BigInt.new(1) }) { |i, objct| objct[i] = i * objct[i-1i64] % MOD; objct }
FACTORIALS_i = FACTORIALS.map { |i| inv(i, MOD) }


def comb(n, k)
  FACTORIALS[n] * FACTORIALS_i[k] * FACTORIALS_i[n - k] % MOD
end

# def f(n, k, mem)
#   return BigInt.new(1) if n == 0
#   tuple = {n, k}
#   puts mem.size if mem.size % 1000 == 0
#   return mem[tuple] if mem.has_key?(tuple)
#   p = f(n - 1, k + 1, mem)
#   mem[tuple] = if k >= 2
#                   ans = 0i64
#                   (2..k).step(2).each { |i|
#                     ans = (ans + f(n - 1, k - i + 1, mem) * comb(k, i)) % MOD
#                   }
#                   (ans + p) % MOD
#                 else
#                   p
#                 end
# end

# mem = Hash(Tuple(Int32, Int32), BigInt).new

# puts f(4, 0, mem)
# puts f(8, 0, mem)
# puts f(24680, 0, mem)

N = 24680

dp = Array(BigInt).new(N + 1) { BigInt.new(0) }
dp[0] = BigInt.new(1)
dp[1] = BigInt.new(1)

two_inv = inv(BigInt.new(2), MOD)

(2..N).each do |i|
  sum = BigInt.new(0)
  (0..i).each do |k|
    sum += comb(i - 1, k) * dp[i - 1 - k] * dp[k]
  end
  dp[i] = sum * two_inv % MOD
  puts "#{i}: #{dp[i]}"
end
