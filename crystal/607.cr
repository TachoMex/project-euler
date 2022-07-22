# def solve_for_angle(angle)
#   ca = 50.0
#   co = Math.tan(angle) * ca
#   hyp = (ca**2 + co**2)**0.5
#   a = 100.0
#   b = hyp
#   t = Math::PI / 4 - angle
#   c = (a**2 + b**2 - 2 * a * b * Math.cos(t))**0.5
#   x = c
#   y = hyp / 5
#   # puts "x: #{x} y #{y}"
#   x/10+1879*y/2520
# end

# min = 100.0

# left = 0.0
# right = 1.0
# delta = 0.000_000_0001

# while (right - left) > delta
#   med = (left + right) / 2
#   f_med = solve_for_angle(med)
#   puts "#{med} #{f_med}"
#   f_left = solve_for_angle(med - delta)
#   f_right = solve_for_angle(med + delta)
#   left_derivative = f_med - f_left
#   right_derivative = f_right - f_med
#   min = Math.min(Math.min(Math.min(min, f_med), f_right), f_left)
#   if left_derivative < 0 && right_derivative > 0
#     break
#   elsif left_derivative < 0 && right_derivative < 0
#     left = med
#   elsif left_derivative > 0 && right_derivative > 0
#     right = med
#   else
#     break
#   end
# end

# N = 360
# (0..N).each do |i|
#   angle = (2 * Math::PI / N) * i
#   f = solve_for_angle(angle)
#   min = Math.min(f, min)
#   puts "(#{angle}, #{f})"
# end

# puts min
# # # y =
# # # => 14.142135623730951
# # # x = (100 - 5 * 10 * 2**0.5) / 2
# # => 29.289321881345245
# # x/5+1879*y/2520
# # => 16.40273454967796
# # x/10+1879*y/2520
# # => 13.473802361543436

segment_speeds = [9, 8, 7, 6, 5, 10]
min = 100

N = 100
TOP = 20

SIDE = x = (100**2/2) ** 0.5
X_SEGMENT = (SIDE - 50.0)


population = Array.new(N) { Array.new(segment_speeds.size) { rand * 10 } }

def calculate_cost(path : Array(Float64), costs)
  cost = 0.0
  total_y = 0.0
  (0...5).each do |i|
    length = (10**2 + path[i]**2)**0.5
    cost += length / costs[i]
    total_y += path[i]
  end
  left = ((SIDE - total_y)**2 + X_SEGMENT**2)**0.5
  cost += left / 10
  cost
end

def avg(x, y, fixture)
  a, ca = x
  b, cb = y
  a, b = b, a if cb < ca
  a.zip(b).map { |x, y| [x, y, (x + y + fixture) / 2].sample }
end

last_err = 14
1000000.times do
  costs = population.map { |pop| calculate_cost(pop, segment_speeds) }
  err = costs.sum / costs.size
  fixture = err < last_err ? 0.0001 : -0.0001
  puts "#{err} #{min} #{fixture}"
  costs.each { |c| min = Math.min(min, c) }
  best = population.zip(costs).sort { |a, b| _, a = a; _, b = b; a <=> b }[0...TOP]
  new_population = (0..N).map do
    a = best.sample
    b = best.sample
    avg(a, b, fixture)
  end
  last_err = err
  population = new_population
  # population = Array.new(N) { Array.new(segment_speeds.size) { rand * 10 } }
end

# pp population

puts min
