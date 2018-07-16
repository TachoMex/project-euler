n = 100_000
dp = Array.new(n + 1, 0)
dp[0] = 1
(1..n).each do |i|
  (i..n).each do |j|
    dp[j] = (dp[j] + dp[j - i]) % 10**6
  end
  if dp[i] == 0
    puts i
    break
  end
end
