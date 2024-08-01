require "big"
require "./lib/number_theory"
include NumberTheory
MOD = 10.to_big_i**9+7

def xor_prod(a, b)
  acc = 0i128
  bits = 0i128
  while b.positive?
    acc ^= a << bits if b.odd? 
    bits += 1
    b >>= 1
  end 
  acc
end

def xor_prodi(a, b)
  acc = 0.to_big_i
  bits = 0.to_big_i
  while b.positive?
    acc ^= a << bits if b.odd? 
    bits += 1
    b >>= 1
  end 
  acc
end

def p(n)
  if n == 0
    0.to_big_i
  elsif n == 1
    11.to_big_i
  else
    t = p(n//2)
    t = xor_prodi(t, t)
    t = xor_prodi(t, 1.to_big_i) if n % 2 == 1
    t
  end
end

def bf(n)
  acc = 11.to_big_i
  (n-1).times { acc = xor_prodi(acc, 11.to_big_i) }
  acc
end

# Sierpinsky triangle generates, powers of 2 have only 3 ones
# (1..20).each do |i|
#   puts "#{i} => #{p(i).to_s(2)}"
# end

# Refactoring 8**12 * 12**8
# (2**36) * 3**8 **2**16
# 2**52 * 3**8

# Pattern of powers of 2
# (1..10).each do |i|
#   puts "#{i} => #{p(2**i).to_s(2).split('1').map(&.size)} | #{2**(i+1) - 1} #{2**i - 1}"
# end

# # Pattern of how 3**8 * 2**x changes in binary
# (0..5).each do |i|
#   ones = bf(3.to_big_i**8*2**i).to_s(2).chars.reverse.map_with_index { |d, idx| {d, idx} }.select { |d, idx| d == '1' }.map { |_, idx| idx }
#   # puts ones.size # => 441
#   puts ones[0..10]
#   # puts "0 | #{(2**(12+i))} | #{3 * (2**(12+i))}"
# end

ans = 0.to_big_i
ones = bf(3.to_big_i**8).to_s(2).chars.reverse.map_with_index { |d, idx| {d, idx} }.select { |d, idx| d == '1' }.map { |_, idx| idx }

ones.each do |one|
  ans = (ans + modpow(2.to_big_i, (one * 2.to_big_i**52), MOD)) % MOD
end

puts ans