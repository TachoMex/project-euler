primes = [2, 3, 5, 7, 11, 13, 17]
puts ('0'..'9').to_a
               .permutations
               .map { |p| p.join }
               .select { |p| (0..6).all? { |i| p[i + 1, 3].to_i % primes[i] == 0} }
               .map { |p| p.to_i64 }
               .sum
