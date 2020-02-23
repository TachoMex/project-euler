require "./lib/number_theory"

SUMS = [[9], [8, 1], [7, 2], [7, 1, 1], [6, 3], [6, 2, 1], [6, 1, 1, 1],
        [5, 4], [5, 3, 1], [5, 2, 2], [5, 2, 1, 1], [5, 1, 1, 1, 1],
        [4, 4, 1], [4, 3, 2], [4, 3, 1, 1], [4, 2, 2, 1],
        [4, 2, 1, 1, 1], [4, 1, 1, 1, 1, 1], [3, 3, 2, 1], [3, 3, 1, 1, 1],
        [3, 3, 3], [3, 2, 2, 2], [3, 2, 2, 1, 1], [3, 2, 1, 1, 1, 1],
        [3, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 1], [2, 2, 2, 1, 1, 1],
        [2, 2, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1]]

include NumberTheory

prime_tester = PrimeTesterWithSieve(Int64).new(500_000)

solutions = [] of String
(1..9).to_a
      .each_permutation do |p|
        SUMS.map do |s|
          memo = [] of Int64
          elements = 0
          s.each do |e|
            memo << p[elements, e].join.to_i64
            elements += e
          end
          solutions << memo.sort.join('|') if memo.all? { |p| prime_tester.prime?(p) }
        end
      end
puts solutions.uniq.size
