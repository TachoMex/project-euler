require "./lib/number_theory"
include NumberTheory

def f(n, path, idx, forms)
  if n == path.sum
    forms << path + [n]
    return
  end
  return if n < path.sum || idx >= 10

  p = path.clone
  p << idx

  f(n, path, idx + 1, forms)
  f(n, p, idx, forms)
end

forms = [] of Array(Int32)
(1..9).each do |i|
  f(i, [] of Int32, 1, forms)
end

# puts forms

def s(n)
  ans = 0
  (1...10**n).each do |i|
    digits = i.to_s.chars
    max_digit = digits.max.to_i
    sum = digits.map { |d| d.to_i }.sum
    if sum == 2 * max_digit
      puts i
      ans += i
    end
  end
  return ans
end

MOD = 10_000_000_000_000_000i64

FACTORIALS = (1i64..2022i64).each_with_object(Array(BigInt).new(2024) { BigInt.new(1)}) { |i, objct| objct[i] = i * objct[i-1i64]; objct }

def inverse(a, p)
  _, x, _ = extended_euclidean(a, p)
  (x + p) % p
end

# FACTORIALS_i = FACTORIALS.map { |i| inv(i, MOD) }


def comb(list)
  n = list.sum
  ans = FACTORIALS[n]
  list.each do |digit|
    ans //= FACTORIALS[digit]
  end
  ans
end

def solve(n, forms)
  f = forms.select { |i| i.size <= n }
  ans = BigInt.new(0)
  ones = (BigInt.new(10)**n-1)//9
  f.each do |x|
    freq = Array(Int32).new(10, 0)
    freq[0] = n - x.size
    (1..9).each { |j| freq[j] = x.count(j) }
    c = comb(freq)
    ans += c * x.sum
    # puts "#{x} => #{freq} #{c}"
  end
  ans // n * ones
end

puts solve(2020, forms) % MOD
# (1i64..7).each do |i|
#   puts "#{i} => #{solve(i, forms)}"
# end