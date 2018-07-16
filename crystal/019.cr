r = (1901..2000).map do |y|
  (1..12).map do |m|
    Time.new(y, m, 1)
  end
end.flatten.select { |d| d.sunday? }.size


puts r
