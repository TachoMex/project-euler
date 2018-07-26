graph = File.read_lines("../107.in")
            .map do |raw|
              raw.gsub("-", "-1")
                 .split(',')
                 .map { |n| n.to_i}
            end
n = graph.size
visited = Array.new(n, false)
distance = Array.new(n, 1_000_000)

distance[0] = 0
prim = 0

(0...n).each do |i|
  best = 0
  distance_best = 1_000_000
  visited.each_with_index do |visited_j, j|
    next if visited_j
    next if distance[j] > distance_best
    best = j
    distance_best = distance[j]
  end

  visited[best] = true
  prim += distance[best]

  (0...n).each do |i|
    next if graph[best][i] == -1
    distance[i] = [distance[i], graph[best][i]].min
  end
end
weight = graph.flatten.select { |x| x >= 0 }.sum / 2
saving = weight - prim
puts saving
