require "big"
puts (1..100).map { |a| (1..100).map { |b| (BigInt.new(a) ** b).to_s.chars.map { |c| c.to_i}.sum  }}.flatten.max
