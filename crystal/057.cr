require "./lib/continuous_fraction"

f = ContinuousFraction.new([1] + [2] * 1000)
r = (1..1000).count do |i|
  num, den = f.fraction(i)
  num.to_s.size > den.to_s.size
end

puts r
