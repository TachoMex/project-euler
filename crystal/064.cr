require "./lib/continuous_fraction"

r = 0

(2..10_000).each do |i|
  next if (i ** 0.5).to_i**2 == i
  d = PeriodicContinuousFraction.new(i)
  d.find_cycle
  r += 1 if d.period_size.odd?
end

puts r
