require "./lib/number_theory"
include NumberTheory

# TOP = 1_000_000_000

# primes, sieve, parent = longest_prime_divisor_sieve(TOP + 1)
# primes = primes.map { |p| p.to_big_i }

# puts "Sieve ready"

# set = Set(BigInt).new

# puts (1i64..100_000).map do |k|
#   square = 4i64*k**2 + 1
#   puts k if square > TOP
#   parent[square]
# end.sum

N = 10_000_000


def sieve_4k2_1(n, p, sieve, max_primes)
  while n <= N
    while sieve[n] % p == 0
      max_primes[n] = Math.max(max_primes[n], p)
      sieve[n] //= p
    end
    n += p
   end
end

sieve = (0i128..N).map { |x| 4i128 * x**2 + 1 }
max_primes = [0i128] * (N + 1)

(1i128..N).each do |i|
  p = sieve[i]
  if p > 1
    sieve_4k2_1(i,  p, sieve, max_primes)
    sieve_4k2_1(p - i, p, sieve, max_primes)
  end
end

# pp max_primes
puts max_primes.sum % 1_000_000_000_000_000_000