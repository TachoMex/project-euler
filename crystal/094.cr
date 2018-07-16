require "./lib/continuous_fraction"

answer = 0
d = 3
p = PeriodicContinuousFraction.new(d)
p.find_cycle
f = p.continuous_fraction(1000)

(1..1000).each do |i|
  x, y = f.fraction(i)
  a = 2 * x - 1
  break if a >= 1_000_000_000

  if x**2 - d * y**2 == 1
    if a % 3 == 0 && y * (x - 2) > 0
      answer += a - 1
    end

    a_2 = 2 * x + 1
    if a_2 % 3 == 0 && y * (x - 2) > 0
      answer += (a_2 + 1).to_i
    end
  end
end

puts answer
