# # def partitions(n, k, arr, path, idx)
# #   if path.sum == n
# #     arr << path.clone
# #   elsif path.sum < n && idx <= k
# #     partitions(n, k, arr, path, idx + 1)
# #     path << idx
# #     partitions(n, k, arr, path, idx)
# #     path.pop
# #   end
# # end

# def balanced_partition?(partition : Array(Int32), n : Int32, sum : Int32, idx : Int32)
#   if sum * 2 == n
#     true
#   elsif sum * 2 > n || idx == partition.size
#     false
#   else
#     balanced_partition?(partition, n, sum, idx + 1) || balanced_partition?(partition, n, sum + partition[idx], idx + 1)
#   end
# end

# # def balanced_partitions?(partitions, n)
# #   partitions.all? do |partition|
# #     balanced_partition?(partition, n, 0, 0)
# #   end
# # end

# def partitions2(n, k, path, idx)
#   if path.sum == n
#     balanced_partition?(path, n, 0, 0)
#   elsif path.sum < n && idx <= k
#     return false unless partitions2(n, k, path, idx + 1)
#     path << idx
#     ans = partitions2(n, k, path, idx)
#     path.pop
#     ans
#   else
#     true
#   end
# end

# def balanced_partitions?(n, k)
#   arr = [] of Int32
#   partitions2(n, k, arr, 1)
# end

# (1..5).each do |k|
#   n = 2
#   switch = false
#   while !switch
#     puts "testing f(#{n}, #{k})"
#     switch = balanced_partitions?(n, k)
#     n += 2
#   end
#   puts "#{k} => #{n - 2}"
# end

# # 1 2  3  4   5
# # 2 4 12 24 120
# # 2 3 2

require "number_theory"


include NumberTheory
N = 100_000_000
MOD = 1_000_000_007
primes, sieve = sieve(N + 1)

ans = 1.to_big_i
primes.each do |p|
  cum = p.to_i128
  while cum * p <= N
    cum *= p
  end
  ans = ans * cum % MOD
end

puts ans * 2 % MOD

# puts primes.reduce { |a, b| a.to_big_i * b } % MOD

# puts factors((1.to_big_i..30).reduce { |a, b| lcm(a, b) } * 2)