def sumatory(n)
  n * (n + 1) // 2
end

def f(n)
  sum = 0i64
  i = 1i64
  while n > 0
    sum += i * sumatory(n)
    n -= 3
    i += 1
  end
  sum
end


puts (1i128..12343).map { |n| f(n) }.sum
