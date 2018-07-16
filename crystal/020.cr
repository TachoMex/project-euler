require "big"

puts (BigInt.new(1)..BigInt.new(100)).product.to_s.chars.map { |c| c.to_i }.sum
