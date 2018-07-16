require "./lib/number_theory"
include NumberTheory

_, sieve = sieve(10000)

(1488..10000).each do |a|
  b = a + 3330
  c = b + 3330
  next if sieve[a]
  next if sieve[b]
  next if sieve[c]
  next if a.to_s.chars.sort != b.to_s.chars.sort
  next if a.to_s.chars.sort != c.to_s.chars.sort
  puts "#{a}#{b}#{c}"
  break
end
