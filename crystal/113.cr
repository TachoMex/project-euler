require "big"

# def increasing?(n)
#   n.to_s == n.to_s.chars.sort.join
# end

# def decreasing?(n)
#   n == n.chars.sort.reverse.join
# end

# def bouncy?(n)
#   n = n.sub(/^0+/, "")
#   !increasing?(n) && !decreasing?(n)
# end

# def find(n, path)
#   # return 0 if path.size > 0 && path[0] == '0' 
#   return 0 if path.size > 0 && bouncy?(path)
#   if path.size == n
#     # puts path
#     return 1
#   end
#   if increasing?(n)
#   end
#   (0..9).map { |d| find(n, path + d.to_s) }.sum
# end


# def f(n, last, asc, desc, path)
#   if n == 0
#     return bouncy?(path.join) ? 0 : 1
#     if (asc && !desc) || (desc && !asc)
#       00
#     else 
#       puts "#{path.join} | #{bouncy?(path.join)}"
#       1
#     end
#   else
#     (0i32..9i32).map do |idx|
#       new_path = path + [idx]
#       f(n - 1, idx, asc && (last && idx >= last),  desc && (last && idx <= last), new_path).as(Int32)
#     end.sum
#   end
# end

# puts f(3, nil, true, true, [] of Int32)
# (3..7).each { |i| puts find(i, "") - 1 }

# mem = {} of Int32 => Hash(Int32, Int32)

# inc = Set(Int32).new
# dec = [] of Int32

# def incresing_count(last, path, n, inc)
# def incresing_count(last, path, n) : Int128
#   if last > 9
#     0i128
#   elsif path.size > n
#     0i128
#   else
#     # puts path.join unless path.empty?
#     # inc << path.join.to_i unless path.empty?
#     path << last
#     ans = incresing_count(last, path, n)
#     path.pop
#     ans += incresing_count(last + 1, path, n)
#     ans += 1 unless path.empty? || last != path[-1]
#     ans
#   end
# end

# def decresing_count(last, path, n : Int32) : Int128
#   if last < 0
#     0i128
#   elsif path.size > n
#     0i128
#   else
#     # puts path.join unless path.empty?
#     path << last
#     ans = decresing_count(last, path, n)
#     path.pop
#     ans += decresing_count(last - 1, path, n)
#     ans += 1 unless path.empty? || last != path[-1]
#     ans
#   end
# end

def factorial(n : BigInt) : BigInt
  n == 0 ? 1.to_big_i : n * factorial(n - 1)
end

def comb(n, k) : BigInt
  factorial(n) // factorial(k) // factorial(n - k)
end
 
def decresing_count_c(n)
  comb(11 + n - 1, n) - 1
  # (1i128..n).map { |i| comb(i + 10 - 1, 10) }.sum
end

def incresing_count_c(n)
  comb(10 + n - 1, n) - 1
  # (1i128..n).map { |i| comb(i + 10 - 1, 10) }.sum
end

# puts inc.size
# puts incresing_count(1i8, [] of Int8, 11) 
# puts incresing_count_c(11)
# puts decresing_count(9i8, [] of Int8, 11)
# puts decresing_count_c(11)
i = incresing_count_c(100.to_big_i)
d = decresing_count_c(100.to_big_i)
# puts d
puts i + d - 100 - 100 * 9

# puts (1..10).map { |i| }.sum
# puts find(20, "") - 1
# (1..1000_000).each do |i|
#   if increasing?(i) && !inc.includes?(i)
#     puts "#{i} is missing"
#   elsif !increasing?(i) && inc.includes?(i)
#     puts "#{i} is left"
#   end
# end
