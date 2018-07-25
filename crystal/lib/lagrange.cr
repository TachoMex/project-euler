class LagrangeInterpolator
  def initialize(points : Array(Tuple(Float64, Float64)))
    @points = points
  end

  def [](x)
    interpolate(x)
  end

  def interpolate(x)
    @points.map_with_index { |p, j| p[1] * lagrange(j, x) }.sum
  end

  def lagrange(j, x)
    @points.map_with_index { |p, m| j == m ? 1 : (x - p[0]) / (@points[j][0] - p[0]) }.product
  end
end
