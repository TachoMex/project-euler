require "./lib/number_theory"
require "./lib/geometry"
include NumberTheory
include Geometry

N = 100

CENTER = Point(Int64).new(0, 0)

def ccw(x1, y1, x2, y2, x3, y3)
  (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)
end

# def point_inside_triangle(px, py, x1, y1, x2, y2, x3, y3)
#   d1 = ccw(px, py, x1, y1, x2, y2)
#   d2 = ccw(px, py, x2, y2, x3, y3)
#   d3 = ccw(px, py, x3, y3, x1, y1)
#   has_neg = [d1, d2, d3].all? { |x| x.negative? }
#   has_pos = [d1, d2, d3].all? { |x| x.positive? }
#   has_zero = [d1, d2, d3].any? { |x| x.zero? }
#   !(has_neg && has_pos) && !has_zero
# end

# def lattice_v4(a, b)
#   ans = 0
#   (1...a).each do |x|
#     (1...b).each do |y|
#       if point_inside_triangle(x, y, 0, 0, 0, b, a, 0)
#         ans += 1
#         # puts "(#{x}, #{y})"
#       end
#     end
#   end
#   ans
# end

# def lattice_v3(a, b)
#   return lattice(b, a) if a > b

#   m = b / a
#   # puts m
#   sum = 0
#   (1...a).each do |x|
#     sum += (m*x).to_i
#     sum -= 1 if (m * x).to_i.to_f == m * x && (m * x).to_i > 0
#   end
#   sum
# end

# def lattice_v2(a, b)
#   return lattice(b, a) if a > b

#   dy = -a
#   dx = b
#   m = dy / dx
#   sum = 0
#   (1..b).each do |x|
#     y = m * x + a
#     sum += (y - 0.001).to_i
#   end
#   sum
# end

def lattice(a, b)
  ans = 0
  pb = Point(Int64).new(0, b)
  pa = Point(Int64).new(a, 0)
  t = Triangle.new(CENTER, pa, pb)

  (1...a).each do |x|
    (1...b).each do |y|
      p = Point(Int64).new(x, y)
      if t.contains?(p)
        # puts "(#{x}, #{y})" if a == 2 && b == 5
        ans += 1
      end
    end
  end
  ans
end

# def lattice(a, b)
#   v1 = lattice_v1(a, b)
#   v2 = lattice_v2(a, b)
#   v3 = lattice_v3(a, b)
#   # v4 = lattice_v4(a, b)
#   puts({v1, v2, v3, a, b}) if v1 != v2 || v2 != v3
#   v1
# end

options = Array(Array(Int64)).new(N + 1) { Array(Int64).new(N + 1, 0) }

(1..N).each do |a|
  (a..N).each do |b|
    c = lattice(a, b)
    # puts({a, b, c})
    options[a][b] = options[b][a] = c
  end
end

count = 0
(1..N).each do |a|
  (1..N).each do |b|
    (1..N).each do |c|
      (1..N).each do |d|
        points = options[a][b] + options[b][c] + options[c][d] + options[d][a] + a + b + c + d - 3
        if square_number?(points)
          # puts({a, b, c, d})
          count += 1
        end
      end
    end
  end
end

puts count
