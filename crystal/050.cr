require "./lib/number_theory"
include NumberTheory

N = 1_000_000_i64
primes, sieve = sieve(N)
n = primes.size
r_size = 0
r = 0
sums = Array(Int64).new(n) { 0_i64 }
sums[0] = primes[0]
(1...n).each { |i| sums[i] = sums[i - 1] + primes[i] }
(0...n).each do |i|
  (i + 1...n).each do |j|
     size = j - i + 1
     p = sums[j] - (i == 0 ? 0 : sums[i - 1])
     break if p >= N
     next if sieve[p]
     next if r_size > size
     r_size = size
     r = p
  end
end

puts r
