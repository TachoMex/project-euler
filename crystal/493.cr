require "big"

ONE = BigFloat.new(1.0, 20)

def e(g, n, b)
  return 0.0 if g <= 0
  return 0.0 if n <= 0

  BigFloat.new(b.to_f, 20) / (g + b) * e(g, n - 1, b - 1) + BigFloat.new(g.to_f, 20) / (g + b) * (ONE + e(g - 10, n - 1, b + 9))
end

puts e(70, 5, 0)