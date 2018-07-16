require "./lib/number_theory"

include NumberTheory


n = 200
primes, sieve = sieve(n + 1)
m = primes.size

dp = Array.new(m) { Array.new(n + 1, 0) }

dp[0][0] = 1

(0...primes.size).each do |i|
  (0..n).each do |j|
    dp[i][j] += dp[i - 1][j]
    dp[i][j] += dp[i][j - primes[i]] if j - primes[i] >= 0
  end
end


(1..n).each do |i|
  x = dp[m - 1][i]
  x -= 1 unless sieve[i]
  if x > 5_000
    puts i
    break
  end
end
