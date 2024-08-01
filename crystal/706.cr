# a][ b = 1i128, 4i128
# sum = 0i128
# sum2 = 5i128
# 10i128.times do |i|
#   a, b = b, 4 * b + 9 * a
#   sum2 += b
#   puts "#{i + 1} #{(10i128 ** (i + 1)) //3 - sum} #{b} #{sum2}"
#   sum += (10i128 ** (i + 1)) // 3
# end

# def substrings(s)
#   indices = (0...s.length).to_a
#   indices.product(indices).reject{ |i, j| i > j }.map{ |i, j| s[i..j] }
# end

# puts (100..999).select { |i| substrings(i.to_s).count { |s| s.to_i % 3 == 0 } % 3 == 0 }

N = 1_00_000
MOD=1_000_000_007

dp = (0..N).map { (0...3).map { (0...3).map { (0...3).map { (0...3).map { 0i64 } } } } }

dp[1][1][1][0][0] = 3i64
dp[1][0][0][1][0] = 3i64
dp[1][0][0][0][1] = 3i64

sum = 0i128
(1..N).each do |n|
  (0...3).each do |m|
    (0...3).each do |a|
      (0...3).each do |b|
        (0...3).each do |c|
          if n < N
            next_a = (a + 1) % 3
            dp[n + 1][(m + a + 1) % 3][next_a][b][c] += 4i64 * dp[n][m][a][b][c] % MOD
            dp[n + 1][(m + c) % 3][c][next_a][b] += 3i64 * dp[n][m][a][b][c] % MOD
            dp[n + 1][(m + b) % 3][b][c][next_a] += 3i64 * dp[n][m][a][b][c] % MOD
          elsif m.zero?
            sum = (sum + dp[n][m][a][b][c]) % MOD
          end
        end
      end
    end
  end
end

puts sum

