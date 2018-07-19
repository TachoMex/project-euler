require "big"
i = 10_i128 ** 8 + 1
j = 10_i128 ** 10

TARGET = "123456789".to_big_i

while i <= j
  x = (i**2).to_s
  filtered = (0...x.size).select { |i| i.even? }.map { |i| x[i] }.join.to_big_i
  if filtered == TARGET
    puts i * 10
    break
  end
  i += 2
end
