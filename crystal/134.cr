require "number_theory"
include NumberTheory

N = 1_000_010
primes, _ = sieve(N)

ans = 0

tenshift = 10i128

primes.each_with_index do |p2, i|
  next if i == 0 || p2 <= 5
  p1 = primes[i - 1]
  while tenshift <= p1
    tenshift *= 10
  end

  s = (p2-p1) * inv_euclid(tenshift, p2) % p2
  next if s <= 0 || (tenshift * s + p1) % p2 != 0
  puts "#{p1} #{p2} #{s} #{tenshift * s + p1}"
  ans += tenshift * s + p1

  # (1..p2).each do |j|
  #   x = tenshift * j + p1
  #   if x % p2 == 0 
  #     ans += j
  #     puts "#{p1} #{p2} #{x} #{x % p2}"
  #     break 
  #   end
  # end

end


puts ans