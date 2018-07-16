require "./lib/number_theory"
include NumberTheory

(145_i64..90000_i64).each do |a|
  p_a = hexagonal_number(a)
  next unless triangular_number?(p_a)
  next unless pentagon_number?(p_a)
  puts p_a
  break
end
