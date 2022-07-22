def xyz(s)
  freq = s.chars.group_by { |i| i }.to_h { |k, v| {k, v.size} }
  top = freq.values.max
  tuple = freq.find { |k, v| v == top }
  return "" if tuple.nil?
  x, _ = tuple
  x = 'A' if x == '0'
  s.gsub(x, 'X').gsub('0', 'Z').gsub(/\d/, 'Y')
end

def f_(n)
  count = 0
  # patterns = [] of String
  (10**(n - 1)...10**n).each do |i|
    if i.to_s.chars.group_by { |i| i }.to_h { |k, v| {k, v.size} }.values.max * 2 > n
      count += 1
      # patterns << xyz(i.to_s.rjust(n, '0'))
      # puts i if xyz(i.to_s) == "YXX"
    end
    # puts i.to_s.rjust(n, '0').chars.group_by { |i| i }.to_h { |k, v| {k, v.size} }
  end
  # puts patterns.group_by { |s| { s.count('X'), s.count('Y'), s.count('Z') }.join(' ') }.to_h { |k, v| {k, v.size} }.to_a.sort.join("\n")
  count
end

def f(n)
  (1..n).map { |i| f_(i) }.sum
end

def pow(a, b, c)
  if b == 0 || a == 1
    1i64
  elsif b == 1
    a.to_i64
  else
    h = (b/2).to_i64
    t = pow(a, h, c)
    t * t % c * pow(a, b % 2, c) % c
  end
end

def inv(a, p)
  pow(a, p - 2, p)
end

MOD = 1_000_000_007i64

FACTORIALS = (1i64..2022i64).each_with_object(Array(Int64).new(2024, 1i64)) { |i, objct| objct[i] = i * objct[i-1i64] % MOD; objct }
FACTORIALS_i = FACTORIALS.map { |i| inv(i, MOD) }

def comb_(x, y, z)
  y_base = x.zero? ? 9i64 : 8i64
  FACTORIALS[x + y + z] * FACTORIALS_i[x] % MOD * FACTORIALS_i[y] % MOD * FACTORIALS_i[z] % MOD * pow(y_base, y, MOD) % MOD * 9i64 % MOD
end

def comb(x, y, z)
  ans = if z == 0
          comb_(x, y, 0)
        elsif x == 0
          comb_(0, y - 1, z)
        elsif y == 0
          comb_(x - 1, 0, z)
        else
          (comb_(x - 1, y, z) + 8i64 * comb_(x, y - 1, z)) % MOD
        end
  # puts "#{x} #{y} #{z} => #{ans}"
  ans
end

def f2(n)
  ans = 0i64
  n_half = (n / 2).to_i64 + 1

  (n_half...n).each do |z|
    y = n - z
    ans = (ans + comb(0, y, z)) % MOD
  end

  (n_half..n).each do |x|
    (0..n - x).each do |y|
      z = n - x - y
      ans= (ans + comb(x, y, z)) % MOD
    end
  end
  ans
end

# 1 => ok: 9 == 9.0
# 2 => ok: 9 == 9.0
# 3 => ok: 252 == 252.0
# 4 => ok: 333 == 333.0
# 5 => ok: 7704 == 7704.0
# 6 => ok: 11430 == 11430.0
# 7 => ok: 245520 == 245520.0

sum = 0
(1..2022).each do |i|
  x = f2(i)
  sum = (sum + x) % MOD
  puts "#{i} => #{x} :: #{sum}"
end
puts sum