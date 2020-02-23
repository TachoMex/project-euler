
i = 1
j = 10 ** 30

TARGET = 1234567890

while i <= j
  k = (i + j) / 2
  x = (k**2).to_s
  filtered = (0...x.size).select { |i| i.even? }.map { |i| x[i] }.join.to_i
  puts x
  if filtered == TARGET
    puts k
    break
  elsif filtered < TARGET
    i = k + 1
  else
    j = k - 1
  end
end

