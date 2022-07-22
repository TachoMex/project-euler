require "./lib/number_theory"
include NumberTheory

N = 100_000_000

primes, sieve = sieve(2 * N)

def f(p, sieve)
  idx = 1i64
  return false unless sieve[p]
  while idx * idx <= p
    return false if p % idx == 0 && sieve[idx + (p/idx).to_i]
    idx += 1
  end
  true
end

sum = 0i64
(1..N).each do |i|
  valid = f(i,sieve)
  sum += i if valid
end
puts sum + 2