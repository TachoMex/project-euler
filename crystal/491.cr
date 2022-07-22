# def f(k)
#   digits = ((0..k).to_a * 2).sort
#   count = 0
#   digits.each_permutation do |p|
#     # next if p[0] == 0
#     n = p.join.to_i128
#     if n % 11 == 0
#       count += 1
#       # puts "#{n} #{count}"
#     end
#   end
#   count
# end

# f(2)


# def rec(digits, idx, left, right, left_digits)
#   if idx == digits.size
#     if left == right && left_digits.size * 2 == digits.size
#       [left_digits.clone]
#     else
#       [] of Array(Int32)
#     end
#   elsif left_digits.size * 2 > digits.size || (idx - left_digits.size) * 2 > digits.size
#     [] of Array(Int32)
#   else
#     ans = rec(digits, idx + 1, left, right + digits[idx], left_digits)
#     left_digits << digits[idx]
#     ans += rec(digits, idx + 1, left + digits[idx], right, left_digits)
#     left_digits.pop
#     ans
#   end
# end

# def complement(arr, n)
#   ans = [] of Int32
#   (0..n).each do |i|
#     ans += [i] * (2 - arr.count {|x| x == i} )
#   end
#   ans
# end

# def f(n)
#   digits = ((0..n).to_a * 2).sort
#   total = [2] * 10
#   ans = 0i128
#   solutions = rec(digits, 0, 0, 0, [] of Int32).uniq
#   solutions.each do |sol|
#     compl = complement(sol, n)
#     compl_permutations = compl.each_permutation.size
#     sol.each_permutation do |per|
#       next if per[0] == 0
#       ans += compl_permutations
#     end
#   end
#   ans
# end

# puts complement([0, 0, 1, 1, 5, 5, 7, 8, 9, 9], 9)


# def f(n)
#   ans = 0i128
#   # mem = Set(Int128).new
#   [0, 1, 2].each_repeated_permutation(n+1, true) do |p|
#     next if p.sum != n + 1
#     digits = p.zip(0..n).map { |count, digit| [digit] * count }.flatten
#     next if digits.sum != n * (n + 1) // 2
#     q = p.map { |x| 2 - x }.zip(0..n).map { |count, digit| [digit] * count }.flatten.permutations.uniq.size
#     digits.permutations.uniq.each do |v|
#       next if v[0] == 0
#       # hash = v.join.to_i128
#       # next if mem.includes?(hash)
#       # puts v
#       # puts q
#       ans += q
#       # q.each_permutation do |w|
#       #   z = v.zip(w).map {|a, b| [a, b] }.flatten.join.to_i128
#       #   next if mem.includes?(z)
#       #   if z % 11 == 0
#       #     # puts "#{z} #{v} #{w}"
#       #     ans += 1
#       #     mem << z
#       #   end
#       # end
#       # mem << hash
#     end
#   end
#   # ((0..n).to_a * 2).each_permutation do |p|
#   #   next if p[0] == 0
#   #   l = p.join.to_i128
#   #   # puts "#{l} >>>> #{l % 11}" unless mem.includes?(l)
#   #   # if l % 11 == 0 && !mem.includes?(l)
#   #   #   puts ":v #{l}"
#   #   # end
#   # end
#   ans
# end

def factorial(n : Int128)
  (1i128..n).reduce { |a, b| a * b }
end

def permutations_with_leading_zero(arr)
  ans = factorial(arr.size)
  (0..9).each do |i|
    count = arr.count { |x| x == i }
    ans //= factorial(count) if count >= 2
  end
  ans
end

def permutations_without_leading_zero(arr)
  has_zero = arr.any? { |x| x.zero? }
  if has_zero
    ans = factorial(arr.size - (has_zero ? 1 : 0))
    (0..9).each do |i|
      count = arr.count { |x| x == i } - (has_zero && i.zero? ? 1 : 0)
      ans //= factorial(count) if count >= 2
    end
    permutations_with_leading_zero(arr) - ans
  else
    permutations_with_leading_zero(arr)
  end
end


def f(n)
  ans = 0i128
  mem = Set(Int128).new
  base = [0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9]
  [0, 1].each_repeated_permutation(2*n+2) do |p|
    digit = p.zip(base).map { |flag, digit| flag == 1 ? digit : nil}.compact
    next if digit.size != n + 1
    second_half = p.zip(base).map { |flag, digit| flag == 0 ? digit : nil}.compact
    next if (digit.sum - second_half.sum) % 11 != 0
    hash = digit.join.to_i128
    next if mem.includes?(hash)

    # puts digit
    # puts second_half
    ans += permutations_with_leading_zero(second_half) * permutations_without_leading_zero(digit)
    mem << hash
  end
  ans
end

puts f(1)
puts f(2)
puts f(3)
puts f(4)
puts f(5)
puts f(6)
puts f(7)
puts f(8)
puts f(9)

# 2
# 24
# 486
# 15840
# 810000
