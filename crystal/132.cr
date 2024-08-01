require "number_theory"
include NumberTheory

N = 1000000
K = 40
R = 1_000_000_000

primes, _ = sieve(N)


def rep_unit(n, k)
  i = inv_euclid(9, n)
  # puts "(#{i} * #{n}) % #{k} = #{i * n % k}"  
  ((modpow(10i128, k , n) - 1) * i) % n
end

k = 0
sum = 0

primes[3..].each do |p|
  if rep_unit(p, R) == 0
    puts p
    sum += p
    k += 1
    break if k == K
  end
end

puts sum