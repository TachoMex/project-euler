N = 1_000_000_i64

class Collatz
  getter :collatz

  def initialize(n : Int64)
    @n = n
    @collatz = Array(Int64).new(N) { 0_i64 }
    @calculated = Array(Bool).new(N) { false }
  end


  def calculate(n : Int64) : Int64
    return 1_i64 if n == 1
    return @collatz[n] if n < N && @calculated[n]

    next_number = (n.even? ? n / 2_i64 : 3_i64 * n + 1_i64)
    c = calculate(next_number) + 1_i64

    if n < N
      @calculated[n] = true
      @collatz[n] = c
    end

    c
  end
end

c = Collatz.new(N)

m = (1_i64..N).map { |i| c.calculate(i.to_i64) }.max
puts c.collatz.index { |x| x == m}
