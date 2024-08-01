require "./fraction"

class MathField
  @rational : Fraction
  @root : BigInt
  @root_fraction : Fraction

  getter :rational, :root, :root_fraction

  def initialize(@root, @rational = Fraction.new(0.to_big_i, 1.to_big_i), @root_fraction = Fraction.new(0.to_big_i, 1.to_big_i))
  end

  def root_string
    return "" if @root_fraction.zero?
  end

  def zero?
    @rational.zero? && @root_fraction.zero?
  end

  def to_s
    if zero? 
      "0"
    elsif @rational.zero?
      "#{@root_fraction.to_s}sqrt(#{@root})"
    elsif @root_fraction.zero?
      @rational.to_s
    else
      "#{@rational.to_s}#{(root_fraction.positive? ? "+" : "")}#{@root_fraction.to_s}sqrt(#{@root})"
    end
  end

  def +(o)
    case o
    when Int
      MathField.new(@root, rational + o, root_fraction)
    when MathField
      raise "BadMath" if @root != o.root
      MathField.new(@root, rational + o.rational, root_fraction + o.root_fraction)
    else 
      raise "BadMath"
    end
  end
 
  def - : self
    MathField.new(@root, -rational, -root_fraction)
  end

  def -(o)
    case o
    when Int
      MathField.new(@root, rational - o, root_fraction)
    when MathField
      raise "BadMath" if @root != o.root
      MathField.new(@root, rational - o.rational, root_fraction - o.root_fraction)
    else 
      raise "BadMath"
    end
  end
  
  def *(o)
    case o
    when Int
      MathField.new(@root, rational * o, root_fraction * o)
    when MathField
      raise "BadMath" if @root != o.root
      MathField.new(@root, 
      rational * o.rational + Fraction.new(root, 1.to_big_i) * root_fraction * o.root_fraction, 
      rational * o.root_fraction + root_fraction * o.rational)
    else 
      raise "BadMath"
    end
  end
  
  def /(o)
    case o
    when Int
      MathField.new(@root, rational / o, root_fraction / o)
    when MathField
      raise "BadMath" if @root != o.root
      r = Fraction.new(root, 1.to_big_i)
      a = rational
      b = root_fraction
      c = o.rational
      d = o.root_fraction
      k = c * c - r * d * d
      MathField.new(@root,
        (a * c - r * b * d) / k,
        (c * b - a * d) / k
      )
    else 
      raise "BadMath"
    end
  end

  def **(n)
    raise "BadMath" unless n.is_a?(Int)
    case n 
    when 0
      MathField.new(root, Fraction.new(1.to_big_i, 1.to_big_i))
    when 1
      self
    else
      x = self**(n//2)
      x *= x
      n.even? ? x : x * self
    end
  end

  def sqrt
    if root_fraction.zero?
      MathField.new(root, rational.sqrt)
    else 
      raise "BadMath"
    end
  end
end