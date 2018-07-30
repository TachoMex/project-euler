def count(m, n, mem)
  return 0 if n < 0
  return 1 if n == 0
  return mem[n] if mem[n] != -1

  sum = 0_i64
  m.each do |block|
    sum += count(m, n - block, mem)
  end
  mem[n] = sum
  mem[n]
end

N = 50
mem = Array.new(N + 1, -1_i64)

puts count([1, 2, 3, 4], N, mem)
