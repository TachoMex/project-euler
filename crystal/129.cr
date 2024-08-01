require "number_theory"
include NumberTheory

# def rep_unit(n, k)
#   i = inv_euclid(9, n)
#   # puts "(#{i} * #{n}) % #{k} = #{i * n % k}"  
#   if 9 * i % n != 1 
#     x = (modpow(10i128, k + 1, n))
#     3.times do 
#       return (x // 9) % n if x % 9 == 0
#       # puts "Im I looping? #{x % 9} #{n} #{k}"
#       x += n
#     end
#     return ("1"*k).to_big_i % n
    
#     puts "#{n} #{k} #{i} #{9 * i % n}"
#     raise "Oh no!"
#   end 
#   ((modpow(10i128, k + 1, n) - 1) * i) % n
# end

# def factors_til(n : T, top) forall T
#     i = T.new(3)
#     factors = [] of T
#     while n.even?
#       factors << T.new(2)
#       n = n//2
#     end
#     while i * i <= n && i <= top
#       while (n % i).zero?
#         factors << i
#         n //= i
#       end
#       i += 2
#     end
#     factors << n unless n == 1
#     factors
#   end

# def divs_from_factors_til(n : BigInt, top)
#   divs = [1.to_big_i]
#   factors_til(n, top).group_by { |v| v }.to_h { |k, v| { k, v.size } }.each do |p, b|
#     divs_2 = [] of BigInt
#     (0..b).each do |i|
#       divs.each do |d|
#         new_factor = d * p ** i
#         break if new_factor > top
#         divs_2 << new_factor
#       end
#     end
#     divs = divs_2
#   end
#   divs
# end


N = 1000000
# ans = Array(Int32|Nil).new(2*N + 1, nil)

# best = 2*N
# best_idx = 2*N
# (1..2*N).each do |i|
#   r = ((10.to_big_i**(i) - 1) // 9)
#   puts "#{i} =>" if i % 100 == 0
#   divs_from_factors_til(r, 2*N).each do |k|
#     ans[k] ||= i
#     if ans[k].as(Int32) == i && i >= N && k < best_idx
#       best_idx = k
#       best = i
#       puts "#{best_idx} #{k}"
#     end
#   end
# end

# ans.each_with_index do |i, solution|
#   # puts "#{solution} #{i || -1 }"
#   if i && i >= 1000000
#     puts "#{solution} #{i || -1 }"
#     # puts solution 
#     break
#   end
# end

# tester = PrimeTester(Int64).new

# (N..N+100).each do |n|
#   next if n % 2 == 0 || n % 5 == 0
#   puts n
#   (2..).each do |i|
#     if rep_unit(n, i) == 0
#       puts "#{i} #{n} ok"
#       if i >= N
#         puts "Found: #{n}"
#         exit(0)
#       else
#         break
#       end
#     end
#   end
# end

def a(n)
  return 0 if n % 2 == 0 || n % 5 == 0
  k = 1i128
  acc = 1i128
  while acc % n != 0
    k += 1
    acc = (acc * 10i128 + 1) % n
  end
  k
end

(N..).each do |n|
  k = a(n)
  # puts "#{k} #{n}"
  if k >= N
    puts n
    break 
  end
end