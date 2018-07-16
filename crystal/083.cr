matrix = File.read_lines("../081.in")
             .map do |row|
               row.split(',').map { |x| x.to_i }
             end
# matrix = [
#   [131, 673, 234, 103, 18],
#   [201, 96, 342, 965, 150],
#   [630, 803, 746, 422, 111],
#   [537, 699, 497, 121, 956],
#   [805, 732, 524, 37, 331]
# ]

class P083
  Steps = [{ 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 }]
  getter :distances

  def initialize(matrix : Array(Array(Int32)), distances : Array(Array(Int64)), visited : Array(Array(Bool)))
    @matrix = matrix
    @n = uninitialized Int32
    @n = matrix.size
    @visited = visited
    @distances = distances
    @distances[0][0] = matrix[0][0].to_i64
  end

  def solve
    (@n * @n).times do
      x, y = find_next
      visit(x, y)
    end
  end

  def find_next
    best = { 0, 0 }
    distance = INFTY
    (0...@n).each do |i|
      (0...@n).each do |j|
        next if @visited[i][j]
        next if @distances[i][j] > distance
        distance = @distances[i][j]
        best = { i, j }
      end
    end
    return best
  end

  def visit(i, j)
    @visited[i][j] = true
    Steps.each do |di, dj|
      new_i = di + i
      new_j = dj + j
      next if new_i < 0 || new_i >= @n
      next if new_j < 0 || new_j >= @n
      next if @visited[new_i][new_j]
      distance = @distances[i][j] + @matrix[new_i][new_j]
      next if @distances[new_i][new_j] <= distance
      @distances[new_i][new_j] = distance
    end
  end
end

INFTY = 1_000_000_000_000_000_000_i64
n = matrix.size
solver = P083.new(matrix, Array.new(n) { Array.new(n, INFTY) }, Array.new(n) { Array.new(n, false) })
solver.solve

puts solver.distances[n - 1][n - 1]
