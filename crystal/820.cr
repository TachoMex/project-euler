# def loop_index(k, size, start_at, sequence, n)
#   loop_size = size - start_at + 1
#   index_in_loop = (k - start_at - 1 + loop_size) % loop_size
#   # puts "index: #{index_in_loop} loop_size: #{loop_size} size: #{size} k: #{k}"
#   puts "#{n} loop_size:   #{loop_size}"
#   sequence[index_in_loop + start_at]
# end 

# def digit(n, k)
#   visited = Hash(Tuple(Int32, Int32), Int32).new
#   sequence = Array(Int32).new

#   d = 10 // n
#   r = 10 % n
#   idx = 0
#   visited[{d, r}] = idx
#   sequence << d
#   (k - 1).times do
#     return 0 if d == 0 && r == 0
#     d = r * 10 // n
#     r = r * 10 % n
#     return loop_index(k, idx, visited[{d, r}], sequence, n) if visited.has_key?({d, r})
#     idx += 1
#     visited[{ d, r }] = idx
#     sequence << d
#   end
#   # [d, r]
#   d
# end
require "./lib/number_theory"

include NumberTheory

def digit(n, k)
  modpow(10i128, k - 1, n) * 10 // n
end

def s(k)
  (2..k).map { |n| digit(n, k) }.sum
end


puts s(7)
puts s(100)
puts s(1_000_00)
puts s(10_000_000)