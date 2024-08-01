r_a = 1
r_b = 1
(10..99).each do |a|
  (a + 1..99).each do |b|
    common_digs = a.to_s.chars.select { |s| b.to_s.includes?(s) }
    next if common_digs.size != 1
    digits = [a, b].join.to_s.chars.uniq
    next if digits.size != 3
    ad = a.to_s.delete(common_digs[0]).to_i
    bd = b.to_s.delete(common_digs[0]).to_i
    next if ad >= bd
    next if a == 0
    next if a / 10 == b / 10
    next if a % 10 == b % 10
    d1 = a.gcd(b)
    d2 = ad.gcd(bd)
    next if a / d1 != ad / d2
    next if b / d1 != bd / d2
    r_a *= ad
    r_b *= bd
    puts "#{a}/#{b}"
  end
end
r_d = r_a.gcd(r_b)
puts r_b / r_d
