require "./lib/number_theory"

N = 8

include NumberTheory

prime_tester = PrimeTesterWithSieve(Int64).new(100_000)

sums = Array.new(10, 0_i64)
bests = Array.new(10, 0)

primes = (10_i64**(N - 1)..10_i64**N).select do |p|
  prime_tester.prime?(p)
end

primes.each do |p|
  (0..9).each do |d|
    digits = p.to_s.chars.count { |c| c.to_i == d }
    if digits == bests[d]
      sums[d] += p
    elsif digits > bests[d]
      sums[d] = p
      bests[d] = digits
    end
  end
end

puts sums.sum
