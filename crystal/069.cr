require "./lib/number_theory"

include NumberTheory

primes, _ = sieve(100)

r = 1
k = 0
while r * primes[k] <= 10**6
  r *= primes[k]
  k += 1
end

puts r
