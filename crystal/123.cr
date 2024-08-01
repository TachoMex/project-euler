require "./lib/number_theory"
include NumberTheory

N = 1000000

primes, _ = sieve(N + 1)

# sum = 0i128
primes.each_with_index do |p_n, i|
  p_n = p_n.to_i128
  n = i + 1
  sum = ((modpow(p_n.to_i128-1, n, p_n**2) + modpow(p_n.to_i128+1, n, p_n**2))) % p_n**2
  if sum >= 10i128**10
    puts "#{p_n} #{n} #{sum}" 
    break
  end
end

# puts primes[7036]