def divisors(n)
  sqrt = (n**0.5).to_i
  ((2..sqrt).select { |i| (n % i).zero? }.map { |i| [n / i, i] }.flatten + [1]).uniq
end

(1..10000).select do |i|
  divs = divisors(i).sum
  amicable = divisors(divs).sum
  amicable == i && i != divs
end
