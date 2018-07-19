x = 1_i128
y = 1_i128

while y <= 10_i128**12
  x, y = x * 3 + y * 2 - 2, x * 4  + y * 3 - 3
end

puts x
