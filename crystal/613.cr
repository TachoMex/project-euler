require "./lib/numeric"

def angle_between(x2, y2)
  ans = (Math.atan((40.0f64 - y2)/(30.0f64 - x2))-Math.atan(y2/x2)).abs / Math::PI / 2.0
  return 0.3916721503 if ans.to_s == "-NaN"
  ans
end
# sum = 0.3916757213746363f64 * (93_292_554 + 1)
# sum = 0.0f64
delta = 0.0005f64
puts (0.5f64 -  double_integral(0.0f64, 0.0f64, 30.0f64, 40.0f64, delta, delta) { |x, y| angle_between(x, y) } / 1200.0).round(10)
