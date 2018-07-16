require "./lib/number_theory"

primes = NumberTheory::PrimeTester.new

puts ('1'..'7').to_a
               .permutations
               .map { |p| p.join.to_i }
               .select { |p| primes.prime?(p) }
               .max
