matrix = File.read_lines("../081.in")
             .map do |row|
               row.split(',').map { |x| x.to_i }
             end

N = 80
dp = Array.new(N) { Array.new(N, 0) }
(N - 1).downto(0) do |i|
  dp[i][N - 1] = matrix[i][N - 1]
end

(N - 2).downto(0) do |j|
  (N - 1).downto(0) do |i|
    dp[i][j] = matrix[i][j] + dp[i][j + 1]
  end

  (N - 2).downto(0) do |i|
    dp[i][j] = [dp[i][j], matrix[i][j] + dp[i + 1][j]].min
  end

  (1).upto(N - 1) do |i|
    dp[i][j] = [dp[i][j], matrix[i][j] + dp[i - 1][j]].min
  end
end

puts dp.transpose.first.min
