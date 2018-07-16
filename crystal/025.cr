require "big"

a = BigInt.new(1)
b = BigInt.new(1)
k = 2

while b.to_s.size < 1_000
  a, b, k = [b, a + b, k + 1]
end
puts k
