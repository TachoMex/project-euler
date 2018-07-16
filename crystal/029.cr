require "big"
range = (BigInt.new(2)..BigInt.new(100))
puts range.map { |a| range.map { |b| a**b } }.flatten.uniq.size
