r = (2..999_999)
    .select do |x|
      x.to_s
       .rjust(5, '0')
       .chars
       .map { |i| i.to_i }
       .map { |i| i**5 }.sum == x
    end
    .sum
puts r
