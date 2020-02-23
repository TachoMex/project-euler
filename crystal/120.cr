r = (3..1000).map do |a|
      (1..1000).map { |n| 2 * a * (n * 2 + 1) % (a * a)}.max
    end.sum
puts r
