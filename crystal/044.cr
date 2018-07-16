require "./lib/number_theory"
include NumberTheory

(1_i64..3000_i64).each do |a|
  p_a = pentagon_number(a)
  (1_i64..a).reverse_each do |b|
    p_b = pentagon_number(b)
    x = p_a + p_b
    y = p_a - p_b
    if pentagon_number?(x) && pentagon_number?(y)
      puts y
      exit(0)
    end
  end
end
