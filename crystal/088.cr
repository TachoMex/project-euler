require "./lib/number_theory"

include NumberTheory

K = 12

n = 20
minimuns = {} of Int32 => Int32

(2..n).each do |i|
  f = factors(i)
  next if f.size == 2
  (1..)
    k = i - p - i / p
    puts "#{i} => #{k}"
    minimuns[k + 2] ||= i if k + 2 <= K
end
