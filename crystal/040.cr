str = "."
i = 1
while str.size <= 1000010
  str += i.to_s
  i += 1
end

puts (0..6).map { |n| str[10**n].to_i }.product
