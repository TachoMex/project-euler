require "number_theory"
module Geometry
  include NumberTheory

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

    def distance2(other)
      (x - other.x)**2 + (y + other.y)**2
    end

    def to_s(io)
      io << "P(#{x}, #{y})"
    end

    def to_s
      "P(#{x}, #{y})"
    end
  end

  class Line(T)
    getter :a, :b
    def initialize(a : Point(T), b : Point(T))
      @a = a
      @b = b
    end

    def m
      dy / dx
    end

    def dy
      b.y - a.y
    end

    def dx
      b.x - a.x
    end

    def flip
      Line(T).new(b, a)
    end

    def collide?(other)
      t1 = ccw(a, b, other.a)
      t2 = ccw(a, b, other.b)
      t3 = ccw(other.a, other.b, a)
      t4 = ccw(other.a, other.b, b)
      (t1 * t2 < 0) && (t3 * t4 < 0)
    end

    def to_s
      "L<#{a.to_s}, #{b.to_s}>"
    end

    def canonical_triplet
      dy = a.y - b.y
      dx = b.x - a.x
      dz = -(b.x * a.y - a.x * b.y)
      g = gcd(dy,dx)
      if dx < 0 || dx == 0 && dy < 0
        dy *= -1
        dx *= -1
        dz *= -1
      end
      { dy // g, dx // g, dz / g }
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
