def increasing?(n)
  n == n.to_s.chars.sort.join.to_i
end

def decreasing?(n)
  n == n.to_s.chars.sort.reverse.join.to_i
end

def bouncy?(n)
  !increasing?(n) && !decreasing?(n)
end

count = 1
i = 1

while count.to_f / i * 100 != 99
  count += 1 if bouncy?(i)
  i += 1
end
puts i
