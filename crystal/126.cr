# N = 100
# dist = Array(Array(Array(Int32))).new(N) do
#   Array(Array(Int32)).new(N) do 
#     Array(Int32).new(N, 0)
#   end
# end

# visited = Array(Array(Array(Bool))).new(N) do
#   Array(Array(Bool)).new(N) do 
#     Array(Bool).new(N, false)
#   end
# end

# dx = [0, 0, 0, 0, 1, -1]
# dy = [0, 0, 1, -1, 0, 0]
# dz = [1, -1, 0, 0, 0, 0]

# a = 1
# b = 1
# c = 1

# q = Deque(Tuple(Int32, Int32, Int32)).new

# (1..a).each do |x|
#   (1..b).each do |y|
#     (1..c).each do |z|
#       i = N // 2 - a // 2 + x
#       j = N // 2 - b // 2 + y
#       k = N // 2 - c // 2 + z
#       # puts "#{[i, j, k]}"
#       dist[i][j][k] = 1
#       visited[i][j][k] = true
#       q.push({i, j, k})
#     end
#   end
# end

# while !q.empty?
#   x, y, z = q.shift

#   (0...6).each do |i|
#     nx = x + dx[i]
#     ny = y + dy[i]
#     nz = z + dz[i]
#     next if nx < 0 || ny < 0 || nz < 0 || nx >= N || ny >= N || nz >= N || visited[nx][ny][nz] 
#     visited[nx][ny][nz] = true
#     dist[nx][ny][nz] = dist[x][y][z] + 1
#     q << {nx, ny, nz}
#     # puts "#{[x, y, z]}:>#{dist[x][y][z]} => #{[nx, ny, nz]}:>#{dist[nx][ny][nz]}"
#   end
# end

# M = 30
# count = Array(Int32).new(M + 1, 0)

# (0...N).each do |x|
#   (0...N).each do |y|
#     (0...N).each do |z|

#       next if !visited[x][y][z]
#       k = dist[x][y][z]
#       next if k > M
#       count[k] += 1
#     end
#   end
# end

# puts dist.flatten.sum

# def f(a, b, c, n)
#   n == 1 ? (2 * (a*b + a*c + b*c)) : (f(a, b, c, n - 1) + 4*a*b*c + 8*(n - 2))
# end

# (1...M).each do |i|
#   puts "C(#{a}, #{b}, #{c}, #{i}) = #{count[i + 1]} | #{f(a, b, c, i)}"
# end

# puts dist.map { |matrix| matrix.map {|row| row.join("|")}.join("\n")}.join("\n\n")

T = 1000
M = 20000

count = Array(Int32).new(M + 1, 0)

# used = Set(Tuple(Int32, Int32, Int32)).new

(1..M).each do |a|
  (1..a).each do |b|
    break if a * b > M
    (1..b).each do |c|
      last = 2 * (a*b + a*c + b*c)
      # puts "#{[a, b, c, 1]}" if last == 22
      break if last > M
      # next if used.includes?({a, b, c})
      # used << {a, b, c}
      count[last] += 1
      (0...M).step(8).each do |n|
        last += 4*(a+b+c) + n
        # puts "#{[a, b, c, n]}" if last == 22
        break if last > M
        count[last] += 1
      end
    end
  end
end

# (1..10).each do |i|
#   puts "#{i} DP: #{DP[1][2][3][i]}: F: #{f(1, 2, 3, i)}"
# end

count.each_with_index do |c, idx|
  # puts "#{idx} => #{c}"
  if c == T
    puts idx
    break
  end
end