require "./lib/number_theory"

include NumberTheory

(2_i64..100_000_i64).each do |k|
  n = k * (k + 1) / 2
  d = factors(n)
      .group_by { |v| v}
      .map { |_, v| v.size + 1 }
      .product
  if d >= 500
    puts n
    break
  end
end
