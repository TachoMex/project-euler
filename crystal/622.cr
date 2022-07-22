# require "colorize"
# require "./lib/number_theory"

# include NumberTheory

# def riffle_shuffle(deck)
#   n = deck.size
#   half = n // 2
#   # first_half = deck[0...half].map { |i| (i * 2) % n }
#   # second_half = deck[half..-1].map { |i| (i * 2) % n + 1 }
#   first_half = deck[0...half]
#   second_half = deck[half..-1]
#   first_half.zip(second_half).map { |t| t.to_a }.flatten
# end

# deck = (0..51).to_a

# switch = true

# shuffled = deck
# 9.times do
#   puts shuffled.map { |v| v.to_s.rjust(2, ' ') }.join(" ")
#   shuffled = riffle_shuffle(shuffled)
#   switch = false if shuffled.zip(deck).all? { |a, b| a == b }
# end

# def jumps(n, idx = 1)
#   init = idx
#   ans = [] of Int32
#   half = n // 2
#   loop do
#     ans << idx
#     idx = idx < half ? (idx * 2) : (idx * 2 + 1) % n
#     break if idx == init
#   end
#   ans
# end

# def generate_cycles(n)
#   cycles = [] of Array(Int32)
#   used = Set(Int32).new
#   (0...n).each do |i|
#     next if used.includes?(i)
#     new_cycle = jumps(n, i)
#     used.concat(new_cycle)
#     cycles << new_cycle
#   end
#   cycles
# end

# # solutions = [] of Tuple(Int32, Int32)
# # (2..100).step(2).each do |i|
# #   cycles = generate_cycles(i)
# #   j = cycles.map { |c| c.size }.reduce { |a, b| lcm(a, b) }
# #   puts "#{i.to_s.rjust(3, ' ').colorize(:green)} #{j.to_s.rjust(3, ' ').colorize(:blue)}"
# #   # puts cycles.select { |c| c.size == j }.map { |c| c.sort }
# #   # puts "kk".colorize(:red) if j != cycles.map { |c| c.size }.max
# #   # puts cycles.map { |c| c.sort }
# #   solutions << { i, j } if j <= 100
# #   puts "#{i.to_s.rjust(3, ' ').colorize(:green)} #{j.to_s.rjust(3, ' ').colorize(:blue)} #{i.to_s(2).rjust(10).colorize(:white)} #{j.to_s(2).rjust(10).colorize(:yellow)}"
# #   # puts "#{i.to_s.rjust(3, ' ').colorize(:green)} #{j.to_s.rjust(3, ' ').colorize(:blue)}"
# # end

# (2..100).step(2).each do |i|
#   puts i.to_s.colorize(:green)
#   puts jumps(i, 1)
#   puts (0..i).map { |a| 2i64 ** a % (i - 1) }
# end

# # puts solutions.group_by { |a, b| b }.map { |a, b| {a, b.to_h.keys } }.sort.map { |k, v| "#{v.size.to_s.ljust(4)}:#{k.to_s.rjust(3)}: #{v.map{ |c| c.to_s.rjust(5) }.join(' ')}" }.join("\n")


require "./lib/number_theory"
include NumberTheory


N = 60i128

two_power_n = 2i128**60

target = two_power_n - 1i64

sum = 0i128


divs = divs_from_factors(target)
puts target
puts divs


def jumps(n, idx = 1i128)
  init = idx
  ans = [] of Int128
  half = n // 2
  loop do
    ans << idx
    idx = idx < half ? (idx * 2) : (idx * 2 + 1) % n
    break if idx == init
  end
  ans
end

divs.select do |x|
  if modpow(2i128, N, x) == 1 # && divs_from_factors(x).none? { |div| div < x && modpow(2i128, div, x) == 1 }
    next if jumps(x + 1).size != N
    puts "#{x + 1}"
    sum += x + 1
  end
end

puts sum