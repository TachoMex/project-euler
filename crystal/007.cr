require "./lib/number_theory"
include NumberTheory

N = 150_000

primes, _ = sieve(N)

puts primes[10000]
