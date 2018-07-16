require "big"

squares = BigInt.new
sum = BigInt.new
(1..100).each do |i|
  squares += i * i
  sum += i
end
result = sum * sum - squares
puts result
