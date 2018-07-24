require "json"

# sums = Array(Int32).new(1_000_001, 1)
# (2..500_000).each do |i|
#   (i + i..1_000_000).step(i) do |j|
#     sums[j] += i
#   end
# end

# File.write("sums.txt", sums.to_json)

sums = JSON.parse(File.read("sums.txt"))

visited = Array(Bool).new(1_000_001, false)
chain_number = Array.new(1_000_001, 0)

def travel(sums, visited, size, chain_number, i)
  return -1_000_000 if i > 1_000_000
  return size - chain_number[i] if visited[i]
  visited[i] = true
  chain_number[i] = size
  travel(sums, visited, size + 1, chain_number, sums[i])
end

best = -1
answer = -1

(3..1_000_000).each do |e|
  next if visited[e]
  s = travel(sums, visited, 0, chain_number, e).as(Int32)
  if s > best
    best = s
    answer = e
  end
end

puts answer
