require "./lib/number_theory"

primes = NumberTheory::PrimeTester.new

g = 0
gs = -1
(-999..999).each do |a|
  (-1000..1000).each do |b|
    n = -1
    loop do
      n += 1
      p = n ** 2 + a * n + b
      break unless primes.prime?(p)
    end
    if n > gs
      gs = n
      g = a * b
    end
  end
end
puts g
