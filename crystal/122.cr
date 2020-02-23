N = 20
dp = Array(Int32).new(N, 10000)
dp[0] = 0
dp[1] = 0
dp[2] = 1

(3...N).each do |i|
  dp[i] = i - 1
  (1..i).each do |j|
    dp[i] = if j == i - j
              [dp[i], dp[i - j] + 1].min
            else
              # this solution doest not work because it won't consider
              # shared numbers between (i - j) and (j)
              [dp[i], dp[i - j] + dp[j] + 1].min
            end
  end
  puts "#{i}:> #{dp[i]}"
end


pp (1..200).map { |n| dp[n] }.sum
