require "big"

TWO = BigInt.new(2)
LOG_OF_TWO = Math.log(2, 10)
NATURAL_LOG_OF_TWO = Math.log(2)

def lead_power_of_two(n, d)
  d = n * LOG_OF_TWO
  x = d
  reminder = (x - x.to_i)
  (10.0 ** (2 + reminder)).to_i
end

def p(l, n)
  i = 1
  loop do
    if lead_power_of_two(i, 3) == l
      puts(n)
      n -= 1
      return i if n <= 0
    end
    i += 1
  end
end

puts p(123, 678910)