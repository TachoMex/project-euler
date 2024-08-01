require "./number_theory"

class Fraction
  include NumberTheory
  @num : BigInt
  @den : BigInt


  getter :num, :den

  def initialize(a : BigInt, b : BigInt)
    x = gcd(a, b)
    x *= -1 if a.negative? && b.negative?
    if a.positive? && b.negative?
      a *= -1
      b *= -1
    end
    @num = a // x
    @den = b // x
  end

  def to_s
    if @num == 0
      "0"
    elsif 
      @den == 1
      "#{@num}"
    else
      "#{@num}/#{@den}"
    end
  end

  def +(o)
    case o
    when Int
      Fraction.new(num + o * den, den)
    when Fraction
      Fraction.new(num * o.den + o.num * den, den * o.den)
    else 
      raise "BadMath"
    end
  end
  
  def *(o)
    case o
    when Int
      Fraction.new(num * o, den)
    when Fraction
      Fraction.new(num * o.num, den * o.den)
    else 
      raise "BadMath"
    end
  end
 
  def - : self
    self * -1
  end

  def -(o)
    case o
    when Int
      Fraction.new(num - den * o, den)
    when Fraction
      Fraction.new(num * o.den - o.num * den, den * o.den)
    else 
      raise "BadMath"
    end
  end
  
  def /(o)
    case o
    when Int
      Fraction.new(num, den * o)
    when Fraction
      Fraction.new(num * o.den, den * o.num)
    else 
      raise "BadMath"
    end
  end

  def sqrt
    if square_number?(num.to_big_i) && square_number?(den.to_big_i)
      Fraction.new((num ** 0.5).to_.to_big_i, (den ** 0.5).to_.to_big_i)
    else
      raise "BadMath"
    end
  end

  def zero?
    num.zero?
  end

  def positive?
    num.positive? && den.positive?
  end
end