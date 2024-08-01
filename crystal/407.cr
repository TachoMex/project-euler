require "./lib/number_theory"
include NumberTheory

N = 10_000_000
sum = 0

sieve = Array.new(N + 1, -1)
(2..N).each do |i|
  if sieve[i] == -1
    (i..N).step(i).each do |j|
      sieve[j] = i
    end
  end
end
sieve[1] = 1

# p sieve

def prime_factors(a, sieve)
  ans = [] of Int64
  while sieve[a] != a
    ans << sieve[a]
    a //= sieve[a]
  end
  ans << a
  ans
end

def dividers_from_primes(divs)
  reduced = divs.group_by { |v| v }.to_h { |k, v| {k, v.size} }
  total = reduced.values.reduce(1) { |a, b| a * (b + 1) }
  ans = [] of Int64
  (0...total).each do |i|
    factor = 1i64
    reduced.each do |k, v|
      exp = i % (v + 1)
      factor *= k ** exp
      i //= (v + 1)
    end
    ans << factor
  end
  ans.sort
end
# puts dividers_from_primes([2, 3, 7])
# puts prime_factors(180225, sieve) + prime_factors(180224, sieve)
# puts dividers_from_primes(prime_factors(180225, sieve) + prime_factors(180224, sieve))
# exit(0)

# (1..N).each do |n|
#   ans = (1..n).to_a.reverse.find { |a| a * a % n == a }
#   next if ans.nil?
#   # s = gcd(ans, n)
#   # t = gcd(ans - 1, n)
#   # puts "#{n} #{ans} #{s} #{t} #{ (ans - 1) // t} #{ans // s}"
#   sum += ans
# end

# puts sum

# puts prime_factors(42, sieve)

m = Array.new(N + 1, 1i64)

prev = [] of Int64
(2i64..N).each do |a|
  processing_time = Time.measure do
    nk = a * (a - 1)
    new_divs = prime_factors(a, sieve)
    divs = dividers_from_primes(new_divs + prev)
    prev = new_divs
    divs.each do |n|
      break if n > N
      m[n] = Math.max(a, m[n]) if n <= N && a * a % n == a
    end
  end
  puts "#{a} #{processing_time.seconds}" if a % 100_000 == 0
end

puts m.sum - 2

# a(a - 1) = nk
# n = pq
# a = ps
# a - 1 = qt
# k = st
