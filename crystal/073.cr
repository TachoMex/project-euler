r = 0
upper = 0.5
lower = 1.0_f64 / 3
d = 12_000
(1..d).each do |a|
  (a..d).each do |b|
    next if a.gcd(b) != 1
    div = a.to_f64 / b
    break if div <= lower
    next if div >= upper
    r += 1
  end
end

puts r
