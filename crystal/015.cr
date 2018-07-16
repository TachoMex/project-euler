require "big"
n = (BigInt.new(1)..BigInt.new(40)).to_a.product
k = ((BigInt.new(1)..BigInt.new(20)).to_a.product) ** 2
puts  n / k
