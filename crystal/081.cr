matrix = File.read_lines("../081.in")
             .map do |row|
               row.split(',').map { |x| x.to_i }
             end

N = 80
dp = Array.new(N + 1) { Array.new(N + 1, 0) }
(N - 1).downto(0) do |i|
  dp[N - 1][i] = matrix[N - 1][i] + dp[N - 1][i + 1]
  dp[i][N - 1] = matrix[i][N - 1] + dp[i + 1][N - 1]
end

(N - 2).downto(0) do |i|
  (N - 2).downto(0) do |j|
    dp[i][j] = matrix[i][j] + [dp[i + 1][j], dp[i][j + 1]].min
  end
end

puts dp[0][0]
