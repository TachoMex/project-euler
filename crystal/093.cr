LAMBDAS = [
  -> (a : Float64, b : Float64) { a + b },
  -> (a : Float64, b : Float64) { a - b },
  -> (a : Float64, b : Float64) { a * b },
  -> (a : Float64, b : Float64) { a / b }
]

def solver(set)
  answer = [] of Float64
  set.permutations
      .each do |n|
        a = n[0].to_f
        b = n[1].to_f
        c = n[2].to_f
        d = n[3].to_f
        LAMBDAS.each do |f1|
          LAMBDAS.each do |f2|
            LAMBDAS.each do |f3|
              answer << f1.call(f2.call(f3.call(a, b), c), d)
              answer << f1.call(f2.call(a, f3.call(b, c)), d)
              answer << f1.call(f2.call(a, b), f3.call(c, d))
              answer << f1.call(a, f2.call(f3.call(b, c), d))
              answer << f1.call(a, f2.call(b, f3.call(c, d)))
            end
          end
        end
      end
  answer.select { |n| n == n.to_i && n > 0 }
        .map { |n| n.to_i }
        .uniq
        .sort
end


ans = { 0, 0, 0, 0 }
best = 0
(0..9).each do |a|
  (a..9).each do |b|
    (b..9).each do |c|
      (c..9).each do |d|
        values = solver([a, b, c, d])
        solutions = 0
        (0...values.size).each do |k|
          solutions = k - 1
          break if k + 1 != values[k]
        end
        solutions = values.size if values.size == values.last?

        if solutions > best
          best = solutions
          ans = { a, b, c, d }
        end
      end
    end
  end
end
puts ans.join
