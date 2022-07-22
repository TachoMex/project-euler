# N = 89
N = 23416728348467685
# dp = Array(Array(Symbol)).new(N+1) { Array(Symbol).new(N+1, :l) }

# (1..N).each { |x| dp[1][x] = :w; dp[x][0] = :i }

# (2..N).each do |n|
#   (1..N).each do |prev|
#     (1..Math.min(2 * prev, N)).each do |move|
#       dp[n][prev] = :w if n - move >= 0 && dp[n - move][move] == :l
#     end
#   end
# end

# # puts dp.map { |row| row.join "|" }.join("\n")

# list = [] of Int32
# sum = 0
# (1..N).each do |n|
#   best = n
#   if dp[n][n] == :w
#     (1..N).each do |move|
#       # puts "#{n} #{move} => #{!dp[n - move][move]}"
#       if dp[n - move][move] == :l
#         best = Math.min(best, move)
#       end
#     end
#   end
#   sum += best
#   list << best
#   puts "#{n} #{best}"
# end

# puts list.sort.group_by { |x| x}.to_h { |a, b| {a, b.size}}
# # 454

# puts sum

fibs = [] of Int128

a, b = 1i128, 1i128
loop do
  fibs << b
  break if b >= N
  a, b = b, a + b
end
# puts fibs[0..-3]
ans = fibs[-1] + fibs[-2]
ans += fibs[0..-3].zip(fibs[0..-3].reverse).map { |a, b| a * b }.sum
puts ans
