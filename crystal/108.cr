require "./lib/number_theory"

include NumberTheory

k = 4_i64

loop do
  d = dividers(k * k)
  r = d / 2 + d % 2
  break if r >= 1_000
  k += 1
end
puts k
