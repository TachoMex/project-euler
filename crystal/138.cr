# b = 2x
# h = 2x+-1
# L**2 = (b/2)**2+h**2 = 4x**2+4x**2+-2x+1
# sqrt(8x**2+-2x+1) is an inteneger

require "number_theory"
include NumberTheory


ans = 0i128

(1i128..10000).each do |x|
  x *= 8
  l = (x**2)*5 + 4*x + 1
  
  if square_number?(l.to_big_i)
    puts "b = #{2 * x} h = #{2 * x + 1} L = #{(l**0.5).to_i64}"
  end
  
  l = (x**2)*5 - 4*x + 1
  if square_number?(l.to_big_i)
    puts "b = #{2 * x} h = #{2 * x - 1} L = #{(l**0.5).to_i64}"
  end
end

a = 1i128
b = 17i128

12.times do 
  puts b
  ans += b
  a, b = b, b * 18 - a 
end


puts ans

