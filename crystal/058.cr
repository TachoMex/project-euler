require "./lib/number_theory"

class Espiral
  include NumberTheory

  getter :numbers, :primes, :size

  def initialize
    @size = 0
    @step = 1
    @numbers = [1] of Int32
    @primes = 0
    @prime_tester = PrimeTester.new
  end

  def add_layer
    @size += 2
    new_numbers = (1..4).map { |i| @size * i + @step}
    @primes += new_numbers.count { |p| @prime_tester.prime?(p) }
    @numbers += new_numbers
    @step += @size * 4
  end
end

espiral = Espiral.new
loop do
  espiral.add_layer
  percentage = espiral.primes.to_f / espiral.numbers.size
  break if (percentage * 100).to_i < 10
end
puts espiral.size + 1
