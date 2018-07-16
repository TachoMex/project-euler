N = 200

coins = [1, 2, 5, 10, 20, 50, 100, 200]
dp = Array(Int32).new(N + 1) { 0 }
dp[0] = 1

coins.each do |c|
  (0..N - c).each do |j|
    dp[j + c] += dp[j]
  end
end

puts dp[N]
