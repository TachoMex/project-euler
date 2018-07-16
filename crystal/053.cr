require "big"
FACTORIALS = [BigInt.new(1)] +
             (BigInt.new(1)..BigInt.new(100)).map { |n| (BigInt.new(1)..n).product }

result = (1..100).map { |n| (0..100).map { |r| FACTORIALS[n] / FACTORIALS[r] / FACTORIALS[n - r] } }
                 .flatten
                 .count { |n| n > 1_000_000 }

puts result
