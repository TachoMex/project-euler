require "big"

TEN = BigInt.new(10)
MOD = TEN ** 9 + 7

# class Search
#   def initialize
#     @best = BigInt.new(-1)
#   end

#   def set_best(n)
#     @best = n if @best == -1 || n < @best
#   end

#   def search(left, accum : BigInt, idx)
#     # puts "Searching: #{left} :: #{accum} :: #{idx}"
#     set_best(accum) if left.zero?
#     return if left <= 0
#     return if idx > 9
#     return if @best != -1 && accum > @best

#     search(left, accum, idx + 1)
#     search(left - idx, accum * 10 + idx, idx)
#   end

#   def s(n)
#     @best = -1
#     search(n, BigInt.new(0), 1)
#     @best
#   end
# end


# def s(n)
#   exp = (n/9).to_i64
#   TEN**(exp) * (n % 9) + TEN**(exp) -1
# end

# def s!(n)
#   (1..n).map { |i| s(i)}.sum
# end

# def ones(n)
#   (0...n).map { |i| (TEN ** i) }.sum
# end

def pow(a, b, c)
  if b == 0
    1
  elsif b == 1
    a
  else
    h = BigInt.new(b/2)
    t = pow(a, h, c)
    t * t % c * pow(a, b % 2, c) % c
  end
end

def ones(n)
  if n == 0
    return BigInt.new(0)
  elsif n == 1
    return BigInt.new(1)
  elsif n.even?
    half = BigInt.new(n / 2)
    x = ones(half)
    (x + x * pow(10, half, MOD)) % MOD
  else
    half = BigInt.new(n / 2)
    x = ones(half)
    (x * 10 + x * pow(10, half + 1, MOD) + 1) % MOD
  end
end

def s2(n)
  exp = BigInt.new(n / 9)
  r = n % 9
  sum_r = ((r+1) * r / 2).to_i64
  o = ones(exp)
  fixture = sum_r + BigInt.new((r + 3) * o / 2 * r * 9) % MOD
  ((BigInt.new(5) * pow(10, exp, MOD)) % MOD + BigInt.new(9) * o % MOD - BigInt.new(5) - BigInt.new(9) * exp + fixture) % MOD
end

a, b = BigInt.new(0), BigInt.new(1)
i = 1

sum = BigInt.new(0)

# (0..100).each { |x| puts "#{ones(x)} == #{ones2(x)}" }

while i < 90
  a, b = b, a + b
  i+= 1
  ans = s2(b) % MOD
  puts "#{i} => #{b} => #{ans}"
  sum += ans
  sum %= MOD
end


# (1..100).each do |i|
#   x = s(i)
#   sum += x
#   r = i % 9
#   delta = s2(i) - sum
#   puts sum.to_s + "|" + s2(i).to_s + " | " + i.to_s.rjust(3, '0') + " | #{ delta } | #{r} | #{sumatoria(i)}"
# end
# puts sum
puts sum % MOD
# puts MOD
