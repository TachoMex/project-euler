require "./lib/geometry"

include Geometry

r = 1
n = 2

def area_integral(x)
  (Math.sqrt(-((-2 + x)  * x)) - x  * (-2 + Math.sqrt(-((-2 + x) * x))) + 2 * Math.asin(Math.sqrt(1 - x/2)))/2.0
end

def f(n)
  theta = Math.atan(1.0 / n)

  # f(x) =  -sqrt(-x*(x-2))+1 # circle segment
  # g(x) =  x/n

  x1 = (-Math.sqrt(2.0)  * n**(3.0/2) + n**2 + n)/(n**2 + 1)
  # x1 = (Math.sqrt(2) * n**(3.0/2.0) + n**2 + n)/(n**2 + 1)
  y1 = x1 / n
  segment1 = y1 * x1 / 2

  segment2 = area_integral(1.0) - area_integral(x1)
  segment = segment1 + segment2
  # x2 = 2.0
  # y2 = 2.0 / n

  # p1 = Point(Float64).new(x1, y1)
  # p2 = Point(Float64).new(1.0, 0.0)
  # p3 = Point(Float64).new(1.0, 1.0)

  # c2 = p1.distance2(p2)
  # a2 = p2.distance2(p3)
  # b2 = p1.distance2(p3)
  # a = Math.sqrt(a2)
  # b = Math.sqrt(b2)

  # theta2 = Math.acos((a2 + b2 + c2) / (-2.0 * a * b))

  # sector = theta2/2.0
  # triangle = Triangle(Float64).new(p1, p2, p3).area
  # segment = sector - triangle
  # ans =
  # puts({p1, p2, p3})
end

(1..100000).each do|n|
  y = f(n.to_f64) / (4.0 - Math::PI) * 4.0 * 100
  puts "#{n} => #{ y }"
  break if y <= 0.1
end