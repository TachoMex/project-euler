M = 1818

count = 0

def square?(n)
  (n**0.5).to_i**2 == n
end

(1..M).each do |a|
  (a..M).each do |b|
    (b..M).each do |c|
      count += 1 if square?([a**2 + (b + c)**2,
                             b**2 + (a + c)**2,
                             c**2 + (b + a)**2].min)
    end
  end
end

puts count
