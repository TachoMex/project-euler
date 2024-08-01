require "./lib/number_theory"
include NumberTheory

# N = 1000000

# facts = Array(Array(Int64)).new(N + 1) { [] of Int64}

# (2i64..N).each do |i|
#   if facts[i].empty?
#     k = i
#     while k <= N 
#       (k..N).step(k).each do |j|
#         facts[j] << i
#       end
#       k *= i
#     end
#   end
# end


# ans_v = 9999999.0f64
# ans = -1


# phis = facts.map { |i| phi_e(i) }

# phis.each_with_index do |phi, d|
#   next if d == 0
#   f = phi.to_f64 / (d - 1)
#   if f < ans_v
#     puts "#{phi} #{d} #{f} #{facts[d]}"
#     ans_v = f
#     ans = d
#   end
# end

# puts ans

N = 1000000000i128
TARGET = 15499f64/94744
primes, _ = sieve(30)

puts TARGET

def bf(factors, n, idx, primes)
  if n > N || idx >= primes.size
    phi = phi_e(factors)
    phi.to_f64 / (n - 1) < TARGET ? n : N
  else
    s1 = bf(factors, n, idx + 1, primes)
    factors << primes[idx]
    s2 = bf(factors, n * primes[idx], idx, primes)
    factors.pop
    [s1, s2].min
  end
end

factors = [] of Int128

s = bf(factors, 1i128, 0, primes)
puts "#{s} #{factors(s)}"