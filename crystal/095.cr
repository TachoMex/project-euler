sums = Array(Int32).new(1_000_001, 1)
(2..500_000).each do |i|
  (i + i..1_000_000).step(i) do |j|
    sums[j] += i
  end
end

visited = Array(Bool).new(1_000_001, false)
chains = Array(Int32).new(1_000_001, -1)

def travel(sums, e, i, c, visited, chains, path = [] of Int32)
  return -10_000_000 if i > 1_000_000
  chains[e] = c if e == i && visited[i] && chains[e] == -1
  return chains[i] if visited[i]
  visited[i] = true
  travel(sums, e, sums[i], c + 1, visited, chains)
  chains[i] = chains[e]
end

(3..1_000_000).each do |e|
  travel(sums, e, e, 0, visited, chains)
end
max = chains.max
(1..1_000_000).each do |i|
  if chains[i] == max
    puts i
    exit(0)
  end
end
