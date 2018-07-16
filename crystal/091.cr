count = 0
n = 50
(0..n).each do |x1|
  (0..n).each do |y1|
    (0..n).each do |x2|
      (0..n).each do |y2|
        next if x1 == 0 && y1 == 0
        next if x2 == 0 && y2 == 0
        next if x1 == x2 && y1 == y2
        a = x1**2 + y1**2
        b = x2**2 + y2**2
        c = (x1 - x2)**2 + (y1 - y2)**2
        sides = [a, b, c].sort
        count += 1 if sides[0] + sides[1] == sides[2]
      end
    end
  end
end
puts count / 2
