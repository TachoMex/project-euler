require "./lib/continuous_fraction"
e_f = [2]

(1..35).each { |i| e_f << 1 << 2 * i << 1 }

e = ContinuousFraction.new(e_f)

puts e.fraction(101)[0].to_s.chars.map { |c| c.to_i }.sum
