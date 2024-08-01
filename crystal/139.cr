ans = 1
N = 100_000_000
n = 10_000

ans = 0

(1..n).each do |m|
  (1..m).each do |n|
    next if m.gcd(n) != 1
    next if m.odd? && n.odd?
    a = m**2 - n**2
    b = 2 * m * n
    c = m**2 + n**2
    l = a + b + c
    break if l > N
    (1..N).each do |i|
      ai = a * i
      bi = b * i
      ci = c * i 
      l = ai + bi + ci
      break if l > N
      ans += 1 if ci % (bi - ai).abs == 0

    end
  end
end

puts ans
