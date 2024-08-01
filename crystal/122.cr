N = gets.as(String).to_i

# G = Array(Array(Int32)).new(N + 1) { Array(Int32).new(N + 1, 9999)}
# (1..N).each do |i| 
#   G[i][i] = 0 
#   G[i][i+1] = 1 if i != N
# end

# (0..N).each do |k|
#   (0..N).each do |i|
#     (0..N).each do |j|
#       if G[i][j] + G[j][k] < G[i][k]
#         G[i][k] = G[i][j] + G[j][k];
#       end
#     end
#   end
# end

# 3.times do
#   (1..N).each do |r|
#     (1..N).each do |i|
#       G[i][r * i] = G[1][r] if r * i <= N
#     end
#   end

#   (0..N).each do |k|
#     (0..N).each do |i|
#       (0..N).each do |j|
#         if G[i][j] + G[j][k] < G[i][k]
#           G[i][k] = G[i][j] + G[j][k];
#         end
#       end
#     end
#   end
#   # puts (1..N).map { |i| G[1][i] }.sum
# end

# # (1..N).each do |i|
# #   (1..N).each do |j|
# #     print "#{G[i][j]} "
# #   end
# #   puts
# # end

# (2..N).each do |i|
#   puts "#{i}: #{G[1][i]}"
# end

# N = 200
visited = Array(Bool).new(N + 1, false)
dist = Array(Int32).new(N + 1, 0)
parent = Array(Int32).new(N + 1, -1)
dist[0] = 0
dist[1] = 0
visited[0] = visited[1] = true

q = Array(Int32).new

q.push(1)

until q.empty?
  v = q[0]
  q.shift
  i = v
  parents = [] of Int32

  while i != -1
    parents << i
    i = parent[i]
  end

  parents.reverse_each do |i|
    if v + i <= N && !visited[v + i]
      visited[v + i] = true 
      dist[v + i] = dist[v] + 1
      parent[v + i] = v
      q << v + i
    end
  end
end

puts dist.sum

def search(path, k, n, dist)
  if k == n
    dist[n] = [dist[n], path.size - 1].min
    # puts "#{n} <: #{dist[n]} | #{path}"
    return
  elsif k > n || path.size - 1 > dist[n]
    return
  else
    dist[k] = [dist[k], path.size - 1].min
    path.reverse_each do |i|
      path << i + k
      search(path, k + i, n, dist)
      path.pop
    end
  end
end

# N = 200

# dist = Array(Int32).new(N + 1, 999)
# dist[0] = 0
# dist[1] = 0
path = [1]

search(path, 1, N, dist)

puts dist.sum

# puts search(path, 1, 17, dist)
