permutations = {} of String => Array(Int64)
(1_i64..100_000_i64).each do |n|
  group = (n ** 3).to_s.chars.sort.join
  permutations[group] ||= [] of Int64
  permutations[group] += [n]
end
puts permutations.select { |_, v| v.size == 5 }.values.first[0]**3
