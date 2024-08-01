# require "big"
require "./lib/number_theory"
require "./lib/heap"
include NumberTheory

N = 10_000i128
M = 10_000_000_000_000_000i128
T = 100
# N = 500
# M = 10000
# # 515770147
# N = 10
# M = 100
MOD = 123_456_789_1_i128

# def seed(n)
#   (2..n).map { |i| {i, 0} }
# end

# def square_tuple(i, j)
#   # i^(2^j)
#   { i, j += 1 }
# end

# def iterate(list)
#   # x^(2^n) => log(log(x^(2^n))) => n log(2) + log(log(x))
#   k, _ = list.min_by { |x, n|  }
#   # k, _ = list.min_by { |x, n| x.to_big_i^(2.to_big_i^n) }
#   list[k - 2] = square_tuple(*list[k - 2])
#   {list, k}
# end

def priority_func(x, n)
  n*Math.log(2) + Math.log(Math.log(x))
end

def seed(n)
  heap = HeapWithBlock(Tuple(Int32, Int32)).new do |t1, t2|
    priority_func(*t1) < priority_func(*t2)
  end
  (2..n).each do |i|
    heap.push({i, 0})
  end
  heap
end

def iterate(heap)
  i, j = heap.pop
  heap.push({i, j + 1})
  {heap, i}
end

list = seed(N)
window = Deque(Int32).new
iteration = 0
in_windows = 1 # since 1 is not in list
powers = Array(Int128).new(N + 1, 0)
window_count = Array(Int32).new(N + 1, 0)

M.times do
  _, k = iterate(list)
  powers[k] += 1
  iteration += 1
  window_count[k] += 1
  if window_count[k] == 1
    in_windows += 1
  end
  window.push(k)
  if window.size == N
    window_count[window[0]] -= 1
    in_windows -= 1 if window_count[window[0]] == 0
    window.shift(1) 
    break if in_windows == N
  end 
  # puts "#{list.to_s} | #{k} | #{window.size}:#{window.to_a}"
  # puts k
end

# window.each_with_index do |expected, idx|
#   _, k = iterate(list)
#   if k != expected
#     puts "#{k} != #{expected}"
#     window[idx] = k
#     # exit(1) 
#   else 
#     # puts "#{k} is the expected number"
#   end
# end

left = M - iteration
full_cycles = left // (N - 1)
partial_cycle = left % (N - 1)

(2..N).each { |i| powers[i] += full_cycles }
(0...partial_cycle).each { |i| powers[window[i]] += 1 }

puts "iteration: #{iteration}"
puts "left: #{left}"
puts "full_cycles: #{full_cycles}"
puts "partial_cycle: #{partial_cycle}"
# puts "#{powers} | #{powers.sum}"

ans = (2i128..N).map { |i| modpow(i, modpow(2i128, powers[i], MOD - 1), MOD) }.sum % MOD
puts ans
