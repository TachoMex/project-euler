require "big"
x = 0
(BigInt.new(1)..BigInt.new(100)).each do |a|
  (BigInt.new(1)..BigInt.new(100)).each do |b|
    x += 1 if (a**b).to_s.size == b
  end
end
puts x
