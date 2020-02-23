require "big"

numbers = [] of BigInt
(2..100).each do |a|
  (2..100).each do |b|
    c = a.to_big_i**b
    numbers << c if c.to_s.chars.map { |c| c.to_i }.sum == a
  end
end

puts numbers.sort[29]
