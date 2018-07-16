def recurrying_cicle(n)
  path = {} of Int32 => Int32
  cycle = [] of Int32
  remainder = 1
  k = 1
  while remainder
    return k - path[remainder] + 1 if path[remainder]?
    path[remainder] = k
    remainder = (remainder * 10) % n
    cycle << remainder
    k += 1
  end
  return 0
end
puts (2..1_000).map { |i| recurrying_cicle(i) }.max
