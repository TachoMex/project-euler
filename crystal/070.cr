require "./lib/number_theory"

include NumberTheory
mem = {} of Int64 => Int64
r = (2_i64..10_i64**7_i64)
      .select { |i| phi_e(i, mem).to_s.chars.sort == i.to_s.chars.sort }
      .min_by { |a| a.to_f64 / phi_e(a, mem) }
puts r
