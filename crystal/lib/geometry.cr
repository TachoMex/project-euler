module Geometry
  def cross(a, b)
	   a.x * b.y - a.y * b.x
  end

  def ccw(a, b, c)
    cross(b - a, c - a)
  end

  class Point(T)
    getter :x, :y

    def initialize(x : T, y : T)
      @x = x
      @y = y
    end

    def -(b)
      self.class.new(@x - b.x, @y - b.y)
    end
  end

  class Triangle(T)
    def initialize(points : Array(Point(T)))
      initialize(points[0], points[1], points[2])
    end

    def initialize(a : Point(T), b : Point(T), c : Point(T))
      @a = a
      @b = b
      @c = c
    end

    def contains?(p)
      t_1 = ccw(@a, @b, p)
      t_2 = ccw(@b, @c, p)
      t_3 = ccw(@c, @a, p)
    	(t_1 < 0 && t_2 < 0 && t_3 < 0) || (t_1 > 0 && t_2 > 0 && t_3 > 0)
    end
  end
end
