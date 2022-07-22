require "./lib/number_theory"

include NumberTheory

N = 100_000_000i64

primes, _ = sieve(N + 1)

def inv(a, p)
  modpow(a.to_i64, (p - 2).to_i64, p.to_i64)
end

sum = 0i64

primes[2..-1].each do |p|
  p_1 = -1
  p_2 = 1
  p_3 = inv(p - 2, p)
  p_4 = p_3 * inv(p - 3, p) % p
  p_5 = p_4 * inv(p - 4, p) % p
  f = (p_1 + p_2 + p_3 +p_4 + p_5) % p
  sum += f
end
puts sum