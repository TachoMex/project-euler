require "./lib/math_field"


ROOT_5 = MathField.new(5.to_big_i, root_fraction: Fraction.new(1.to_big_i, 1.to_big_i))
# puts "#{ROOT_5.to_s}"

ONE = MathField.new(5.to_big_i, rational: Fraction.new(1.to_big_i, 1.to_big_i))


PHI = (ROOT_5 + 1)/ 2
# puts "#{PHI.to_s}"

# C1 = 3/2 - 1/(2*ROOT_5)
C1 = MathField.new(5.to_big_i, rational: Fraction.new(3.to_big_i, 2.to_big_i)) - ONE/(ROOT_5*2)
# puts C1.to_s

# C2 = 1/10 * (15 + ROOT_5)
C2 = MathField.new(5.to_big_i, rational: Fraction.new(1.to_big_i, 10.to_big_i)) * (MathField.new(5.to_big_i, rational: Fraction.new(15.to_big_i, 1.to_big_i)) + ROOT_5)
# puts C2.to_s

def g(n)
  C1 * (PHI)**n + C2 * (1f64 / -PHI)**n
end

# (1..10).each do |i|
#   puts "#{i} => #{g(i)}"
# end

def a(x)
  -(C1 * PHI * x * (PHI + x) + C2 * x * (PHI * x - 1)) / ((PHI * x - 1) * (PHI + x))
end

# puts a((ROOT_5-1)/4).to_s
# puts a(MathField.new(5, Fraction.new(2.to_big_i, 5.to_big_i))).to_s

def k_1(k)
  den = ((C1 * PHI + C2 * PHI + PHI * k) * 2)
  s = ((-C1 * PHI**2 + C2 - PHI**2 * k + k)**2 - PHI * 4 * k * (-C1 * PHI - C2 * PHI - PHI * k)) / den / den
  leftover = - C1 * PHI**2 + C2 - PHI**2 * k + k
  # puts "#{k} => #{s.to_s} :: #{den.to_s} :: #{leftover.to_s}"
  -(s.sqrt) + leftover / den
end

# (2..100).each do |i|
#   k = k_1(i)
#   f = a(k)
#   puts "#{k.to_s} #{f.to_s}"
#   # if (disc_f - disc_i).abs <= 0.001 # && square_number?(disc_i.to_big_i)
#   #   puts "#{k} #{f}"
#   # end
# rescue 
# end

# 1/2 5
# 3/5 42
# 8/13 296
# 21/34 2037
# 55/89 13970
# 144/233 95760

# 2/5 2
# 7/12 21
# 19/31 152
# 50/81 1050
# 131/212 7205
# 343/555 49392

fibs = [] of MathField

a, b = 1.to_big_i, 2.to_big_i

30.times do 
  fibs << MathField.new(5.to_big_i, Fraction.new(a, b))
  a, b = b, a + b
  a, b = b, a + b
end

a, b = 2.to_big_i, 5.to_big_i

30.times do 
  fibs << MathField.new(5.to_big_i, Fraction.new(a, b))
  a, b = b, a + b
  a, b = b, a + b
end

ans = MathField.new(5.to_big_i)

ans_i = [] of BigInt

fibs.each do |i|
  f = a(i)
  # puts "#{i.to_s} => #{f.to_s}"
  ans_i << f.to_s.to_big_i
end


puts ans_i.sort[0...30].sum