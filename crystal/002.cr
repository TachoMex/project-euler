a = 1
b = 2
sum = b
while b <= 4_000_000
  a, b = [b, a + b]
  sum += b if b.even?
end
puts sum
