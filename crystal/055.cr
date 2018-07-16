require "big"
def lynchrel?(n : BigInt)
  !(1..50).any? do
    n = n + BigInt.new(n.to_s.reverse)
    n.to_s == n.to_s.reverse
  end
end

puts (BigInt.new(10)...BigInt.new(10_000)).count { |i| lynchrel?(i) }
