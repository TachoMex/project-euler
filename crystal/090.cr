squares = (1..9).map { |x| "%02d" % x**2 }
                .map { |d| d.gsub('9', '6') }
cubes = (0..9).to_a.combinations(6)

def form?(square, a, b)
  a.includes?(square[0].to_i) && b.includes?(square[1].to_i)
end

count = 0
solutions = [] of String
cubes.each do |p|
  cubes.each do |q|
    next if p == q
    s = p.map { |x| x == 9 ? 6 : x }
    t = q.map { |x| x == 9 ? 6 : x }
    next unless squares.all? { |n| form?(n, s, t) || form?(n, t, s) }
    solutions << [p.sort, q.sort].sort.join('|')
  end
end
puts solutions.uniq.size
