def count(m, n, mem)
  return 0 if n < 0
  return 1 if n == 0
  return mem[n] if mem[n] != -1

  sum = 0_i64
  (m..n).each do |k|
    if n - k == 0
      sum += 1
    else
      sum += count(m, n - k - 1, mem)
    end
  end
  mem[n] = sum + count(m, n - 1, mem)
  mem[n]
end

mem = Array.new(50 + 1, -1_i64)

puts count(3, 50, mem)
