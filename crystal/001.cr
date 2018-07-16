# calculates the sum of all the numbers that are divisible by 3 o 5
puts((1...1000).select { |x| (x % 3).zero? || (x % 5).zero? }.sum)
