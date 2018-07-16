require "./lib/number_theory"

include NumberTheory

primes, _  = sieve(2_000_000)
puts primes.sum
