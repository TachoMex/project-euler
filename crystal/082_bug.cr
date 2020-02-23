# @matrix = File.read_lines("../081.in")
#              .map do |row|
#                row.split(',').map { |x| x.to_i }
#              end
matrix = [
  [131, 673, 234, 103, 18],
  [201, 96, 342, 965, 150],
  [630, 803, 746, 422, 111],
  [537, 699, 497, 121, 956],
  [805, 732, 524, 37, 331]
]
N = 5

class P082
  Steps = [{ 1, 0 }, { -1, 0 }, { 0, 1 }]

  getter :best

  def initialize(matrix)
    @best = 10**9
    @n = matrix.size
    @matrix = matrix
    @visited = Array.new(N) { Array.new(N, false) }
  end

  def find(i, j, current)
    return if current > @best
    if j == @n - 1
      @best = [current, @best].min
      return
    end
    @visited[i][j] = true
    current += @matrix[i][j]
    Steps.each do |di, dj|
      new_i = di + i
      new_j = dj + j
      next if new_i < 0 || new_i >= @n
      next if new_j < 0 || new_j >= @n
      next if @visited[new_i][new_j]
      find(new_i, new_j, @visited, current)
    end

    current -= @matrix[i][j]
    @visited[i][j] = false
  end

  def solve
    (0...@n).each do |i|
      find(i, 0, 0)
    end
  end
end

solution = P082.new(matrix)
solution.solve
puts solution.best
