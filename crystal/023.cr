N = 30_000

divs_sum = Array.new(N) { 0 }
dp = Array.new(N) { false }

(1...N).each do |i|
  (i + i...N).step(i) do |j|
    divs_sum[j] += i
  end
end

(24...N).each do |i|
  (12...i).each do |j|
    if divs_sum[j] > j && divs_sum[i - j] > i - j
      dp[i] = true
      break
    end
  end
end

puts (1...N).reject { |i| dp[i] }.sum
