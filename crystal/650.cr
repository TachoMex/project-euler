require "./lib/number_theory"

include NumberTheory

N = 20_000
# pascal = Array(Array(BigInt)).new(N + 1) { Array(BigInt).new(N + 1) { BigInt.new(0)} }

# pascal[0][0] = BigInt.new(1)
# pascal[1][0] = BigInt.new(1)
# pascal[1][1] = BigInt.new(1)

# (2..N).each do |i|
#   pascal[i][0] = BigInt.new(1)
#   (1..N).each do |j|
#     pascal[i][j] = pascal[i-1][j] + pascal[i-1][j-1]
#   end
# end

primes_, _ = sieve(N + 1)

primes = primes_.map { |p| BigInt.new(p) }

def prime_factors(n, primes)
  result = [] of Int32
  i = 0
  while n > 1
    count = 0
    while n % primes[i] == 0
      count += 1
      n //= primes[i]
    end
    i += 1
    result << count
  end
  result
end

MOD = 1_000_000_007

def inv(a)
  modpow(a, MOD - 2, MOD)
end

def dividers_sum(factors, primes)
  return BigInt.new(1) if factors.empty?
  factors.zip(primes).map { |a, p| (modpow(p, a + 1, MOD) - 1 + MOD) * inv(p - 1) % MOD }.reduce { |a, b| a * b % MOD }
  # factors.zip(primes).map { |a, p| (p**(a + 1) - 1) // (p - 1) }.reduce { |a, b| a * b }
end

# puts primes

def factorial_prime_factors(n, primes)
  puts "Calculating #{n}"
  ans = [] of Int32
  i = 0
  while i < primes.size && primes[i] <= n
    count = 0
    t = n
    while t > 0
      count += t // primes[i]
      t //= primes[i]
    end
    ans << count
    i += 1
  end
  ans
end

def factor_vector_add(a, b)
  c = Array(Int32).new(Math.max(a.size, b.size), 0)
  a.each_with_index { |v, i| c[i] += v}
  b.each_with_index { |v, i| c[i] += v}
  c
end

def factor_vector_mult(v, k)
  v.map { |i| i * k }
end

factorials = (0..N).map { |i| factorial_prime_factors(i, primes) }
factorials_sums = Array(Array(Int32)).new(N + 1) { [] of Int32 }
factorials_sums[0] = factorials[0]
(1..N).each { |i| factorials_sums[i] = factor_vector_add(factorials_sums[i - 1], factorials[i] ) }

sum = BigInt.new
(1..N).each do |n|
  prod = factor_vector_mult(factorials[n], n + 1)
  prod = factor_vector_add(prod, factor_vector_mult(factorials_sums[n], -2))
  s = dividers_sum(prod, primes)
  sum = (sum + s) % MOD
  # cool = prime_factors(row.select {|a| a >= 1}.reduce { |a, b| a * b}, primes)
  puts "#{sum} #{n}"
end