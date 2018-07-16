solutions = [] of Int32
(1..9999).map do |x|
  (x..9999).map do |y|
    z = x * y
    solutions << z if [x, y, z].join.chars.sort.join == "123456789"
  end
end
puts solutions.uniq.sum
