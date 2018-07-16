require "./lib/number_theory"

N = 1_000_000
K = 4

class P047
  include NumberTheory
  def initialize
    @factors = {} of Int64 => Array(Int64)
  end

  def grouped_factors(n)
    @factors[n] ||= factors(n).group_by { |v| v }.values.map { |f| f.product }
  end

  def execute
    (1_i64..N).each do |i|
      set = (i...i + K).map { |n| grouped_factors(n) }
      if set.all? { |s| s.size == K }
        puts i
        break
      end
    end
  end
end

P047.new.execute
