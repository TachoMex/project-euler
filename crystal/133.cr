require "number_theory"
include NumberTheory

N = 100000
primes, _ = sieve(N)

def f(n, b = 1)
  acc = 1
  (b..N).each do |i|
    if acc % n == 0
      return i
    end
    acc = (acc * 10 + 1) % n
  end
end

def div_by_2_and_5(n)
  while n % 2 == 0
    n //= 2
  end

  while n % 5 == 0
    n //= 5
  end

  n == 1
end


ans = 0

primes.each do |p|
  x = f(p)
  next if x.nil? || !div_by_2_and_5(x)
  puts p
  ans += p
end

puts primes.sum - ans

