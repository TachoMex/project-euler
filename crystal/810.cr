N = 150_000_000u32
# N = 100
def xor_prod(a : Int64, b : Int64)
  acc = 0i64
  bits = 0
  while b.positive?
    acc ^= a << bits if b.odd? 
    bits += 1
    b >>= 1
  end 
  acc
end

xor_sieve = Array(Bool).new(N, false)
# xor_primes = [] of Int32

(2u32..N).each do |i|
  puts i if i % 10_000 == 0
  (2u32..i).each do |j| 
    ij = xor_prod(i, j)
    if ij < N
      xor_sieve[ij] = true 
    else 
      break
    end
  end
end

p_count = 0

(2u32...N).each do |i|
  if !xor_sieve[i]
    p_count += 1
    if p_count == 5_000_000
      puts "prime found: #{p_count}: #{i}" 
      break
    end
  end
end

# (1..100).each do |i|
#   puts "7 : #{i} = #{xor_prod(7, i)}"
# end


# print "    "
# (0..10).each { |i| print "#{(i).to_s.ljust(3)} " }
# puts
# puts("-" * 50)
# (0..10).each do |a|
#   print "#{a.to_s.ljust(2)} |"
#   (0..10).each do |b|
#     print "#{(xor_prod(a, b)).to_s.ljust(3)} "
#   end
#   puts
# end