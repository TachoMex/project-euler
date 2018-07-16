require "./lib/number_theory"
include NumberTheory

primes, sieve = sieve(1_000_000)
r = primes
    .select { |n| n > 10 }
    .select do |n|
      (1..n.to_s.size)
        .map { |i| [n.to_s[0, i].to_i , n.to_s[i - 1, n.to_s.size].to_i] }
        .flatten
        .none? { |i| sieve[i] }
    end

puts r.sum
