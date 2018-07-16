m = 0
(0..999).each do |a|
  (0..999).each do |b|
    c = a * b
    m = [m, c].max if c.to_s == c.to_s.reverse
  end
end
puts m
