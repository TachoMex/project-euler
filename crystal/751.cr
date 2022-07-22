require "big"
def seq(t)
  b = t
  digits = "2."
  (1..20).each do
    i = b.to_i
    b = i * (b - i + 1)
    digits += b.to_i.to_s
  end
  digits
end

BigFloat.default_precision = 40

EPS = 1.0 / BigFloat.new(10.0, 40)**40

left = BigFloat.new(2.0, 40)
right = BigFloat.new(3.0, 40)


while right - left >= EPS
  mid = (left + right) / 2
  str = seq(mid)
  f_mid = BigFloat.new(str)
  puts "#{BigInt.new(mid * BigFloat.new(10) ** 30)} => #{str}"
  if f_mid < mid
    right = f_mid
  else
    left = f_mid
  end
end
