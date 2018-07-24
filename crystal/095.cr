# sums = Array(Int32).new(1_000_001, 1)
# (2..500_000).each do |i|
#   (i + i..1_000_000).step(i) do |j|
#     sums[j] += i
#   end
# end

# File.write("sums.txt", sums.to_json)

sums = File.read("sums.txt").gsub('[', "").gsub(']', "").split(',').map { |x| x.to_i }

visited = Array(Bool).new(1_000_001, false)

def travel(sums : Array(Int32), visited, path, i)
  return [] of Int32 if i > 1_000_000
  return path + [i] if visited[i]
  visited[i] = true
  travel(sums, visited, path + [i], sums[i])
end

best = -1
answer = -1

(12496..1_000_000).each do |e|
  next if visited[e]
  path = travel(sums, visited, [] of Int32, e)
  next if path.empty?
  size = path.size - (path.index(path.last) || 0) - 1
  if size > best
    best = size
    answer = e
  end
end

puts answer
