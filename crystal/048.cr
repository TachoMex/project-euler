require "big"
puts (BigInt.new(1)..BigInt.new(1000)).map { |x| x ** x % 10_i64**10 }.sum % 10_i64**10
