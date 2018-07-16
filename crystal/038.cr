def pandigit_product(k, n)
  (1..n).map { |i| (k * i).to_s }.join
end

def pandigit_product?(k, n)
  pandigit_product(k, n).chars.sort.join == "123456789"
end
r = { 0, 0 }
(1..10000).each do |n|
  (2..9).each do |k|
    if pandigit_product?(n, k)
      r = { n, k }
    end
  end
end

puts pandigit_product(r[0], r[1])
