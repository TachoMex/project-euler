def count(m, n, mem)
  return 0 if n < 0
  return 1 if n == 0
  return mem[n] if mem[n] != -1

  sum = 0_i64
  if n - m == 0
    sum += 1
  else
    sum += count(m, n - m, mem)
  end
  mem[n] = sum + count(m, n - 1, mem)
  mem[n]
end

def red(n)
  mem = Array.new(N + 1, -1_i64)
  count(2, n, mem) - 1
end

def green(n)
  mem = Array.new(N + 1, -1_i64)
  count(3, n, mem) - 1
end

def blue(n)
  mem = Array.new(N + 1, -1_i64)
  count(4, n, mem) - 1
end


N = 50
puts red(N) + green(N) + blue(N)
