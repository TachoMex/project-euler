require "./lib/number_theory"

include NumberTheory

prime_tester = PrimeTester.new

def lowest_prime(s)
  prime_tester = PrimeTester.new
  (1..9).map { |d| s.gsub('X', d.to_s).to_i }
        .select { |p| prime_tester.prime? p }
        .first
end

4.downto(2) do |x|
  generation_string = "X" * x + "_" * (6 - x)
  generation_string
    .chars
    .permutations
    .map { |x| x.join }
    .uniq
    .each do |pattern|
      p = 6 - x + 1
      (10**(p-1)...10**p).each do |n|
        r = n.to_s.chars.reduce(pattern) { |s, e| s.sub('_', e) }
        s = (0..9).to_a.count do |d|
          number = r.gsub('X', d.to_s).to_i
          prime_tester.prime?(number) && number.to_s.size == generation_string.size
        end
        if s == 8
          puts lowest_prime(r)
          break
        end
      end
    end
end
