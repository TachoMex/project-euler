singles = (1..20).to_a + [25]
doubles = (1..20).map { |n| n * 2 } + [50]
triples = (1..20).map { |n| n * 3 }
darts = singles + doubles + triples

N = 99
result = 0

# m m d
doubles.each do |d|
  result += 1 if d <= N
end

# m s d
# m d d
# m t d
darts.each do |a|
  doubles.each do |b|
    result += 1 if a + b <= N
  end
end

#
# s s d
# s d d
# ...
darts.each_with_index do |a, i|
  darts.each_with_index do |b, j|
    next if i < j
    doubles.each do |c|
      result += 1 if a + b + c <= N
    end
  end
end

puts result
