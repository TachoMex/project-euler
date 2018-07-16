require "big"

class ContinuousFraction
  EPS = 1e-6

  getter :digits

  def initialize(values : Array(Int32))
    @digits = values
    @p = [] of BigInt
    @q = [] of BigInt
  end

  def q(n)
    return @q[n - 1] if @q.size != 0
    @q = [BigInt.new(0), BigInt.new(1)]
    (2..@digits.size).each do |n|
  		@q << @q[n - 1] * @digits[n - 1] + @q[n - 2]
    end
    @q[n - 1]
  end

  def p(n)
    return @p[n - 1] if @p.size != 0
    @p = [BigInt.new(1), BigInt.new(@digits[0])]
    (2...@digits.size).each do |n|
  		@p << @p[n - 1] * @digits[n - 1] + @p[n - 2]
    end
    @p[n - 1]
  end

  def fraction(n)
    { p(n), q(n) }
  end

  def self.approximate(val, iterations = 1000)
    digits = [] of Int32
    loop do
      break if digits.size >= iterations
      digits << val.to_i
      val -= val.to_i
      break if val.abs <= EPS
      val **= -1
    end
    new(digits)
  end
end

class PeriodicContinuousFraction
  def print(i)
    puts [@a[i], @t[i], @k[i], @c[i], @e[i], @t_1[i], @t[i]**-1].join(" | ")
  end

  def initialize(n : Int32)
    @d = n
    @d_sqrt = uninitialized Float64
    @d_sqrt = @d**0.5
    @a = [] of Int32
    @t = [] of Float64
    @t_1 = [] of Float64
    @k = [] of Int32
    @c = [] of Int32
    @e = [] of Int32
    @states = {} of String => Int32
    @i = 0
    first_i
    @i += 1
  end

  def simplify_state
    gcd = @k[@i].gcd(@e[@i]).gcd(@c[@i])
    @k[@i] /= gcd
    @e[@i] /= gcd
    @c[@i] /= gcd
  end

  def calc_next_t_inv
    @t_1 << ((@d_sqrt * @k[@i] + @c[@i])).to_f / @e[@i].to_f
  end

  def first_i
    @a << @d_sqrt.to_i
    @t << @d_sqrt - @a[0]
    @k << 1
    @c << @a[0]
    @e << @d - @a[0]**2
    simplify_state
    calc_next_t_inv
  end

  def current_state
    [@k[@i], @e[@i], @c[@i]].join('|')
  end

  def save_state
    if @states[current_state]?
      nil
    else
      @states[current_state] = @i
    end
  end

  def find_cycle
    loop { break unless iterate }
  end

  def to_s
    "[#{@a[0]}; (#{@a[1..-2].join(", ")})]"
  end

  def period_size
    @a.size - 2
  end

  def iterate
    @a << @t_1[@i - 1].to_i
    a = @a[@i]
    e = @e[@i - 1]
    k = @k[@i - 1]
    c = @c[@i - 1]
    h = c - a * e

    @t << @t_1[@i - 1] - a

    @k << e * k
    @c << - h * e
    @e << k**2 * @d - h**2
    simplify_state
    calc_next_t_inv
    if save_state
      @i += 1
    else
      nil
    end
  end

  def continuous_fraction(n)
    digits =  ([@a[0]] + @a[1..-2] * (n / period_size + 1))
    ContinuousFraction.new(digits)
  end
end
