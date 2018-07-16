require "./lib/continuous_fraction"

solutions = [] of Tuple(BigInt, Int32)
(2..1000).each do |d|
  next if (d ** 0.5).to_i**2 == d
  p = PeriodicContinuousFraction.new(d)
  p.find_cycle
  f = p.continuous_fraction(100)
  (2..100).each do |i|
    x, y = f.fraction(i)
    if x**2 - d * y**2 == 1
      solutions << { x, d }
      break
    end
  end
end
puts solutions.max[1]
