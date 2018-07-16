def solutions(p)
  (1...p).map do |a|
    (a...p).map do |b|
      c = p - a - b
      a ** 2 + b ** 2 == c ** 2
    end
  end.flatten.select { |x| x}.size
end

puts (1..1000).map { |n| solutions(n) }.each_with_index.max[1] + 1
