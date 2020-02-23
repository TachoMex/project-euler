def divisors(n)
  visited = {}
  visited[0] = true
  k = 1
  d = []
  i = 1
  until visited[k]
    visited[k] = i
    i += 1
    d += [k]
    k = 10 * k % n
  end
  k.zero? ? 0 : d.length - visited[k] + 1
end

puts (1..1000).map { |x| [divisors(x), x] }.max
