def increasing?(n)
  n == n.chars.sort.join
end

def decreasing?(n)
  n == n.chars.sort.reverse.join
end

def bouncy?(n)
  !increasing?(n) && !decreasing?(n)
end

def find(n, path)
  return 0 if bouncy?(path)
  if path.size == n
    puts path
    return 1
  end
  (0..9).map { |d| find(n, path + d.to_s) }.sum
end

puts find(3, "")
