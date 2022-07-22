
a_draws = (1..4).to_a.repeated_permutations(9).map{ |a| a.sum }.group_by { |x| x }.map { |k, v| {k, v.size} }
b_draws = (1..6).to_a.repeated_permutations(6).map{ |a| a.sum }.group_by { |x| x }.map { |k, v| {k, v.size} }

wins = 0i128
total = 0i128

a_draws.each do |draw_a, cases_a|
  b_draws.each do |draw_b, cases_b|
    total += cases_a * cases_b
    wins += cases_a * cases_b if draw_a > draw_b
  end
end

puts wins
puts total

puts (wins.to_f64/total).round(7)

