require "./lib/number_theory"
include NumberTheory

N = 800800
TOP_N = Math.log(N) * N
primes, _ = sieve(2_000_000_00)

sum = 0

def f(p, q)
  Math.log(p) * q + Math.log(q) * p
end

primes.each_with_index do |prime, idx|
  break if f(prime, primes[idx + 1]) > TOP_N

  last = idx + 1
  left = idx + 1
  right = primes.size - 1
  while left <= right
    mid = (left + right) // 2
    q = primes[mid]
    f_mid = f(prime, q)
    if f_mid <= TOP_N
      last = mid
      left = mid + 1
    else
      right = mid - 1
    end
  end
  sum += (last - idx)
  puts prime
end
puts sum