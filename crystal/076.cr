n = 100

dp = Array.new(n + 1) { Array.new(n + 1, 0) }
dp[0][0] = 1
(1..n).each { |i| dp[0][i] = 1 }
(1..n).each do |i|
  (1..n).each do |j|
    dp[i][j] += dp[i][j - 1]
    dp[i][j] += dp[i - j][j] if i - j >= 0
  end
end
puts dp[n][n] - 1
