require "./lib/number_theory"
include NumberTheory

N = 100_000_000i128

primes, sieve_ = sieve(N)

idx = 1
sum = 0i128

primes.each do |prime|
  n = prime.to_i128 * prime.to_i128
  reverse = n.to_s.reverse.to_i128
  next if n == reverse
  sq = (reverse ** 0.5).to_i128
  next if sq * sq != reverse
  next if sieve_[sq]
  puts "#{idx} #{n}"
  idx += 1
  sum += n
  break if idx > 50
end

puts sum