require "./lib/lagrange"


def solve(points)
  (1...points.size).map do |s|
    f = LagrangeInterpolator.new(points[0, s])
    f[s + 1]
  end.sum
end

def f(n : Float64)
  { n, 1 - n + n**2 - n**3 + n**4 - n**5 + n**6 - n**7 + n**8 - n**9 + n**10 }
end

# puts solve((1..4).map { |x| {x.to_f64, x.to_f64 ** 3} })
puts solve((1..11).map { |x| f(x.to_f64) })
