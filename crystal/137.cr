# F(x) = x+x^2+2x^3+3x^4..
# F(x) = sum x^n*(phi^n-phi2^n)/sqrt(5)
# F(x) = sum (x^n*phi^n-x^n*phi2^n)/sqrt(5)
# F(x) = sum ((xphi)^n-(xphi2)^n)/sqrt(5)

require "./lib/number_theory"
include NumberTheory

def a(x)
  return -x / (x*x + x - 1)
end

def k_1(x)
  (-x-1+(5*x**2+2*x+1)**0.5) / 2 / x
end

def k_2(x)
  -(x+1+(5*x**2+2*x+1)**0.5) / 2 / x
end

(1..10000).each do |i|
  k = k_1(i)
  x = a(k)
  y = x**2*5+2*x+1
  yi = (y + 0.5).to_i128
  # k2 = k_2(i)
  # x2 = a(k2)
  # puts "#{i} = A(#{k}) => #{a(k)} | #{i} = A(#{k2}) => #{a(k2)}"
  # puts "#{i} = A(#{k}) => #{a(k)} => #{y} => #{yi} => #{(y - yi).abs}"
  if (y - yi).abs <= 0.1 && square_number?(yi.to_big_i)
    puts "#{i} = A(#{k}) => #{a(k)}"
  end
end

a, b = 1i128, 2i128
15.times do |i|
  puts "#{i+1}=> #{a * b}"
  a, b = b, a + b
  a, b = b, a + b
end