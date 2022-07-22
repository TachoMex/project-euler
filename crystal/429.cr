require "./lib/number_theory"
include NumberTheory

N = 100_000_000
MOD = 1_000_000_009

primes, _ = sieve(N + 1)

factors = factorial_prime_factors(N, primes)

# def solve(k, idx, primes, factors)
#   if idx >= primes.size
#     k * k % MOD
#   else
#     (solve(k, idx + 1, primes, factors) + solve((k * modpow(primes[idx], factors[idx], MOD)) % MOD, idx + 1, primes, factors)) % MOD
#   end
# end

# puts solve(1i128, 0, primes, factors)

ans = primes.zip(factors).map { |prime, power| 1i128 + modpow(prime.to_i128 * prime, power, MOD)  }.reduce { |a, b| (a * b) % MOD}

puts ans