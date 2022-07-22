require "./lib/geometry"
require "./lib/number_theory"

include Geometry

include NumberTheory

N = 2500
s0 = 290797

s = [s0] of Int64

(1..2 * N).each do |i|
  s << s[i - 1]**2 % 50515093
end

t = s.map { |p| p % 2000 - 1000 }

points = [] of Point(Int64)

t[1..-1].each_slice(2) { |a| points << Point(Int64).new(a[0], a[1]) }

lines = [] of Line(Int64)

(0...points.size).each do |i|
  (i+1...points.size).each do |j|
    l = Line(Int64).new(points[i], points[j])
    l = l.flip if l.dx < 0
    lines << l
  end
end

lines_classification = {} of Tuple(Int64, Int64) => Set(Float64)

total_lines = 0i128

lines.each do |l|
  a, b, c = l.canonical_triplet
  key = {a, b}
  parallel = lines_classification[key]? || Set(Float64).new
  unless parallel.includes?(c)
    total_lines += 1
    parallel << c
    lines_classification[key] = parallel
  end
end

# puts lines_classification.select { |a, b| b.size > 1 }.map { |tuple, set| "#{tuple.join(" :: ")} [#{set.to_a.sort.join ", "}]" }.sort.join("\n")

puts total_lines
ans = 0i128

lines_classification.each do |m, l|
  # puts l.size if l.size != 1
  ans += (total_lines - l.size) * l.size
end

puts ans