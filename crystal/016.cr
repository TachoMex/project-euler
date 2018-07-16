require "big"

puts (BigInt.new(2) ** 1000).to_s.chars.map { |c| c.to_i}.sum
