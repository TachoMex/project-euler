def gcd(a, b)
  b == 0 ? a : gcd(b, a % b)
end

N = 120000
rad = Array(Int128).new(N + 1, 1)
(2i128..N).each do |i|
  if rad[i] == 1
    (i..N).step(i).each do |j|
      rad[j] *= i
    end
  end
end

count = 0
sum = 0

(1..N).each do |a|
  (1..a).each do |b|
    c = a + b
    break if c > N
    next if gcd(a, b) != 1 || gcd(a, c) != 1 || gcd(b, c) != 1
    next if rad[a] * rad[b] * rad[c] >= c
    puts "#{[a, b, c]}"
    sum += c
    count += 1
  end
end

puts sum
puts count