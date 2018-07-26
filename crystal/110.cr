require "./lib/number_theory"
require "big"

class P110
  include NumberTheory

  getter :solutions

  @solutions : Array(BigInt)
  @primes : Array(Int32)

  def initialize
    @primes, _ = sieve(1000)
    @solutions = [] of BigInt
  end

  def calculate(digits)
    (0...digits.size).map { |i| @primes[i].to_big_i ** digits[i] }.product
  end

  def div(digits)
    digits.map { |n| n * 2 + 1 }.product
  end

  def find(digits, n, options)
    if n == 0 || options.empty?
      x = calculate(digits)
      return if div(digits) < 8_000_000
      @solutions << x
      return
    end
    find(digits + [options.first], n - 1, options)
    find(digits, n, options[1..-1])
  end
end

solver = P110.new
solver.find([] of Int64, 14, [4, 3, 2, 1])

puts solver.solutions.min
