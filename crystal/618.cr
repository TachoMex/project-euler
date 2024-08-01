require "./lib/number_theory"

include NumberTheory

fibs = [2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 17711+28657]

primes, sieve = sieve(fibs.last + 1)

# mem = {} of Tuple(Int32, Int32) => BigInt

# def rec(sum, idx, primes, mem)
#   if sum == 0
#     1.to_big_i
#   elsif sum < 0 || idx >= primes.size || primes[idx] > sum
#     0i128
#   else
#     key = {sum, idx}
#     if mem.has_key?(key)
#       mem[key]
#     else
#       mem[key] = (primes[idx].to_big_i * rec(sum - primes[idx], idx, primes, mem) + rec(sum, idx + 1, primes, mem))
#     end
#   end
# end

dp = Array.new(fibs.last + 1) { BigInt.new }

dp[0] = BigInt.new(1)
primes.each do |p|
  puts p
  (p..fibs.last).each do |i|
    dp[i] += dp[i - p] * p
    dp[i] %= 1_000_000_000
  end
end

sum = BigInt.new
fibs.each do |f|
  sum += dp[f]
  sum %= 1_000_000_000
end

puts sum