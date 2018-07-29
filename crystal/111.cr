require "./lib/number_theory"

include NumberTheory

def m(k, d, prime_tester)
  k.downto(2) do |x|
    numbers = [] of Int64
    generation_string = "X" * x + "_" * (k - x)
    generation_string
      .chars
      .permutations
      .map { |x| x.join }
      .uniq
      .each do |pattern|
        p = k - x + 1
        (0...10_i64**p).each do |n|
          r = n.to_s.rjust(p, '0').chars.reduce(pattern) { |s, e| s.sub('_', e) }
          number = r.gsub('X', d.to_s).to_i64
          if number.to_s.size == generation_string.size && prime_tester.prime?(number)
            numbers << number
          end
        end
      end
      unless numbers.empty?
        numbers = numbers.map { |x| x.to_i128 }.uniq
        puts "%d %d %0d" % [d, x, numbers.size]
        return numbers.sum
      end
    end
  0
end

prime_tester = PrimeTesterWithSieve(Int64).new(300_000)

sums = Array.new(10, 0_i64)

puts (0..9).map { |d| m(10, d, prime_tester) }.sum
