require "./lib/number_theory"
include NumberTheory

N = 100_000_000

primes, sieve = sieve(N + 1)

ans = 0i128

# primes.each_with_index do |a, idx|
#   (idx + 1...primes.size).each do |j|
#     b = primes[j]
#     r = (b + 1) / (a + 1)
#     c = ((a + 1) * r * r).to_i
#     # puts "#{a} #{b} #{c} #{r}"
#     break if c >= N
#     if !sieve[c - 1] && (a + 1) * r == (b + 1) && (a + 1) * r * r == c
#       ans += a + b + c - 1
#       # puts({a, b, c - 1})
#     end
#   end
#   puts a
# end

(2..N).each do |z|
  break if z*z > N
  (2..N).each do |x|
    c = z * z * x -1
    break if c > N
    next if sieve[c]
    (1..z).each do |y|
      next unless z.odd? || y.odd?
      a = x * y * y - 1
      b = x * y * z - 1
      if !sieve[a] && !sieve[b] && gcd(z, y) == 1
        ans += a + b + c
        # puts({a, b, c})
      end
    end
  end
end

puts ans

# 72, 84, 98

