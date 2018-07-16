require "./lib/number_theory"

N = 10_000

include NumberTheory

primes, sieve = sieve(2 * N + 1)
(1..N).each do |i|
  a = 2 * i + 1
  next unless sieve[a]
  found = false
  primes.each do |p|
    x = a - p
    break if x <= 0
    next if x.odd?
    square = x / 2
    if (square ** 0.5).to_i ** 2 == square
      found = true
      break
    end
  end
  unless found
    puts a
    break
  end
end
