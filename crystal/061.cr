require "./lib/number_theory"

include NumberTheory

functions = [->(x : Int32) { pentagon_number?(x) } ,
             ->(x : Int32) { triangular_number?(x) } ,
             ->(x : Int32) { square_number?(x) } ,
             ->(x : Int32) { hexagonal_number?(x) } ,
             ->(x : Int32) { heptagonal_number?(x) } ,
             ->(x : Int32) { octagonal_number?(x) } ]

functions.permutations.each do |funcs|
  (11..99).each do |a|
    (11..99).each do |b|
      x1 = a * 100 + b
      next unless funcs[0].call(x1)
      (11..99).each do |c|
        x2 = b * 100 + c
        next unless funcs[1].call(x2)
        (1..99).each do |d|
          x3 = c * 100 + d
          next unless funcs[2].call(x3)
          (1..99).each do |e|
            x4 = d * 100 + e
            next unless funcs[3].call(x4)
            (1..99).each do |f|
              x5 = e * 100 + f
              x6 = f * 100 + a
              next unless funcs[4].call(x6)
              next unless funcs[5].call(x5)
              list = [x1, x2, x3, x4, x5, x6]
              puts list.sum
              exit(0)
            end
          end
        end
      end
    end
  end
end
