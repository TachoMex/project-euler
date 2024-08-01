s = 290797i64
points = [] of Tuple(Int64, Int64)
N = 2_000_000
MOD = 50_515_093i64

N.times do 
  s1 = (s * s) % MOD
  points << Tuple(Int64, Int64).new(s, s1)
  s = (s1 * s1) % MOD
end

# puts points

def solve_bf(points)
  answer = 100000000f64
  points.each_combination(2) do |comb|
    a, b = comb
    x1, y1 = a
    x2, y2 = b
    dx = (x2 - x1).to_f64
    dy = (y2 - y1).to_f64
    answer = [answer, (dx * dx + dy * dy)**0.5].min
  end
  answer
end

def solve(points)
  if points.size < 10
    solve_bf(points)
  else
    min_x = points.min_by { |p| p.first }.first
    min_y = points.min_by { |p| p[1] }[1]
    max_x = points.max_by { |p| p.first }.first
    max_y = points.max_by { |p| p[1] }[1]
    dx = max_x - min_x
    dy = max_y - min_y
    fx1 = min_x + dx / 4
    fx2 = min_x + 3 * dx / 4
    fy1 = min_y + dy / 4
    fy2 = min_y + 3 * dy / 4
    q1 = [] of Tuple(Int64, Int64)
    q2 = [] of Tuple(Int64, Int64)
    q3 = [] of Tuple(Int64, Int64)
    q4 = [] of Tuple(Int64, Int64)
    points.each do |p|
      x, y = p
      q1 << p if x <= fx1 && y <= fy1 
      q2 << p if x >= fx1 && y <= fy1 
      q3 << p if x <= fx1 && y >= fy1 
      q4 << p if x >= fx1 && y >= fy1 
    end
    [solve(q1), solve(q2), solve(q3), solve(q4)].min
  end
end

answer = solve(points)



puts answer