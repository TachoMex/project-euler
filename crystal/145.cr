N = 1_000_000_000
ans =  (1..N).select { |a| a % 10 != 0 && (a + a.to_s.reverse.to_i).to_s.chars.all? { |c| c.to_i.odd? } }

# pp ans
puts ans.size