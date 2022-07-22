require "colorize"
# def l(n, m)
#   pairs = (0...n).map { |i| (i+1...n).map { |j| {i, j} }  }.flatten
#   bits = [false] * n
#   (0...m).each { |i| bits[i] = true }
#   best_sequence = nil
#   best_sequence_cost = 10000000
#   # 1000.times do
#   pairs.each_permutation(7) do |p|
#     # pairs.shuffle
#     max = 0
#     # puts "testing #{p}"
#     bits.each_permutation do |bits|
#       cost = 0
#       p.each do |a, b|
#         cost += 1
#         break if bits[a] && bits[b]
#       end
#       max = Math.max(cost, max)
#     end
#     # puts max
#     puts p if max <= 7

#     if max < best_sequence_cost
#       best_sequence = p
#       best_sequence_cost = max
#     end
#   end
#   puts best_sequence
#   best_sequence_cost
# end

# puts l(6, 3)

def t(n, r)
  k = r - 1
  # puts "#{n} #{r} #{k}"
  n * (n - 1) // 2 - (k - 1) * n * n // (2 * k)
end

# puts t(8, 2)
# puts t(8, 3)
# puts t(8, 4)
# puts t(8, 5)
# puts t(8, 6)
# puts t(8, 7)
# puts t(8, 8)

# ans = 0
# sum = 0
# (2..1000).each do |n|
#   sum += n * (n - 1) // 2
#   (2..n).each do |m|
#     puts "#{n} #{m} #{t(n, m)}"
#     ans += t(n, m)
#   end
# end

# puts ans
# puts sum - ans

def show_graph(bits)
  n = bits.size
  m = bits.count { |b| b == false }
  puts "T(#{n}, #{m})".colorize(:yellow)
  puts "   #{(1..n).map { |a| a.to_s.ljust(2).colorize(:white)}.join}"
  (1..n).each do |i|
      puts "#{i.to_s.ljust(2).colorize(:white)} #{ (1..n).map { |j| i < j ? (bits[i - 1] && bits[j - 1] ? "O ".colorize(:green) : "X ".colorize(:red)) : "  "  }.join }"

  end
end

show_graph([true, true, true, true, true, true, true, true])

show_graph([true, true, true, true, true, true, true, false])

show_graph([true, true, true, true, true, false, true, false])

show_graph([true, true, true, false, true, false, true, false])

show_graph([true, false, true, false, true, false, true, false])

show_graph([true, false, true, false, true, false, true, false])

show_graph([true, false, true, false, true, false, false, false])
