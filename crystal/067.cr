m = File.read_lines("../067.in")
        .map { |row| row.split(' ').map { |n| n.to_i } }

(0..100).reverse_each do |i|
  (0..i).reverse_each do |j|
    m[i][j] += [m[i+1][j], m[i+1][j+1]].max rescue nil
  end
end


puts m[0][0]
