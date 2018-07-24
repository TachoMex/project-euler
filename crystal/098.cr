words = File.read("../098.in").gsub('"', "").split(',').group_by { |e|  e.size }

def is_square?(n)
  (n**0.5).to_i**2 == n
end

solution = 0

words.each do |size, words|
  words.each do |a|
    words.each do |b|
      next if a == b
      next if a.chars.sort != b.chars.sort
      (1..9).to_a.permutations.map { |p| p[0, size] }
            .uniq
            .each do |p|
              a_aux = a.clone
              b_aux = b.clone
              a.chars.each_with_index do |c, i|
                a_aux = a_aux.gsub(c, p[i].to_s)
                b_aux = b_aux.gsub(c, p[i].to_s)
              end
              a_i = a_aux.to_i
              b_i = b_aux.to_i
              if is_square?(a_i) && is_square?(b_i)
                solution = [solution, a_i, b_i].max
              end
            end

    end
  end
end

puts solution
