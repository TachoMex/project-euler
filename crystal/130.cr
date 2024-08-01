require "number_theory"
include NumberTheory

N = 100000

primes, sieve = sieve(N)
def a(n)
  return 0 if n % 2 == 0 || n % 5 == 0
  k = 1i128
  acc = 1i128
  while acc % n != 0
    k += 1
    acc = (acc * 10i128 + 1) % n
  end
  k
end

acc = 0
j = 6
i = 0
while i < 25
  if sieve[j]
    x = a(j)
    if x != 0 && (j - 1) % x == 0
      puts "#{j} #{x}"
      acc += j
      i += 1
    end
  end
  j += 1 
end

puts acc