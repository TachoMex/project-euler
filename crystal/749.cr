require "colorize"

powers = {}  of Int128 => Array(Int128)
N = 16i128
TOP = 10i128**N

powers[0] = [] of Int128
k = 2i128

count = [0i128, 0i128, 0i128, 0i128, 0i128, 0i128, 0i128, 0i128, 0i128, 0i128, 0i128, 0i128]
# def f(n, path, digits, powers, arr, count)
#   puts "#{n} #{path}"
#   count[0] += 1
#   if n == path + 1 || n == path - 1
#     print("found: ".colorize(:white), n.colorize(:blue), " #{digits}",  "\n")
#     arr << n
#     return true
#   end
#   return false if digits <= 0
#   # return false if n - path > powers.max * digits
#   # return false if path > n
#   # return false if n - path > n + 10i128 ** (digits) - 1i128
#   found = false
#   powers.each_with_index do |p, i|
#   # powers.reverse.each_with_index do |p, i2|
#     # i = 9 - i2
#     # nn = n + (i.to_i128 - 9i128) * 10i128**(digits - 1)
#     nn = n + (i.to_i128) * 10i128**(digits - 1)
#     dd = path + p - powers[9]
#     break if nn >= TOP
#     found_i = f(nn, dd, digits - 1, powers, arr, count)
#     # count[digits] = Math.max(count[1], path - n) if found_i
#     # puts "#{n} #{path} #{nn} #{dd} #{found_i}".colorize( found_i ? :green : :red ) if found_i
#     found ||= found_i
#   end
#   test = "(#{n + 10i128 ** (digits) - 1i128})"
#   print("#{n} #{path} #{found} ".colorize( found ? :green : :red ), "#{test} ".colorize(:magenta), "#{path - n}\n".colorize(:yellow))
#   # print("#{n} #{path} #{found} ".colorize( found ? :green : :red ), "#{test} ".colorize(:magenta), "#{path - n}\n".colorize(:yellow)) if found
#   found
# end

def squares(sum, path)
  sum.to_s.chars.reject { |x| x == '0' }.sort.join == path.join("")
end

def f2(sum, path, k, powers, arr, count, n, top)
  count[0] += 1
  if squares(sum + 1, path)
    arr << sum + 1
    puts "Found: #{sum + 1}"
  end
  if squares(sum - 1, path)
    arr << sum - 1
    puts "Found: #{sum - 1}"
  end
  return if sum >= top || k >= 10 || path.size >= n

  # puts "#{sum}, #{path} #{k}"
  f2(sum, path, k + 1, powers, arr, count, n, top)
  path << k
  f2(sum + powers[k], path, k, powers, arr, count, n, top)
  path.pop
end


loop do
  break if 2i128 ** k >= TOP
  powers[k] = [] of Int128
  (0i128..9).each do |i|
    ik = i ** k
    break if ik >= TOP
    powers[k] << ik
  end
  k += 2
end

p powers

ans = [] of Int128
(2..N).step(2).each do |i|
  # f(10i128**i-1, 0i128, i, powers[i], ans, count)
  # f(0i128, powers[i][9] * i, i, powers[i], ans, count)
  f2(0i128, [] of Int128, 1, powers[i], ans, count, i, 10i128**i)
  puts "========================>"
end
p ans.sort.uniq
p ans.sort.uniq.sum
p count


