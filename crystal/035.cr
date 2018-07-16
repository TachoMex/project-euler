require "./lib/number_theory"
include NumberTheory

primes, sieve = sieve(1_000_000)
r = primes.select do |n|
  (0..n.to_s.size)
    .map { |i| n.to_s.chars.rotate(i).join.to_i }
    .none? { |i| sieve[i] }
end

puts r.size
