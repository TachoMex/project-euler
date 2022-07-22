require "number_theory"
include NumberTheory

primes, _  = sieve(20_000_001)
input = primes.select { |p| p >= 10_000_000}
# primes, _  = sieve(10000+1)
# input = primes

def sam(n)
  return 2 * SEVEN_SEGMENT_WEIGTH[n] if n <= 9
  digits = n.to_s.chars.map { |c| c.to_i }
  digits.map { |d| SEVEN_SEGMENT_WEIGTH[d] }.sum * 2 + sam(digits.sum)
end

# pabcdefg 	hex pabcdefg 	pgfedcba 	hex pgfedcba
SEVEN_SEGMENT_LEDS = [
  0x7E, # 0
  0x30, # 1
  0x6D, # 2
  0x79, # 3
  0x33, # 4
  0x5B, # 5
  0x5F, # 6
  0x72, # 7
  0x7F, # 8
  0x7B, # 9
]

SEVEN_SEGMENT_WEIGTH = (0..9).map { |i| SEVEN_SEGMENT_LEDS[i].to_s(2).chars.map { |c| c.to_i }.sum }

#                         0  1  2  3  4  5  6  7  8  9
# SEVEN_SEGMENT_WEIGTH = [6, 2, 5, 5, 4, 5, 6, 4, 7, 6]

# puts SEVEN_SEGMENT_WEIGTH


# SEVEN_SEGMENT_WEIGTH_TRANSITIONS = [
#   #0, 1, 2, 3, 4, 5, 6, 7, 8, 9
#   [0, 4, 2, 3, 4, 3, 2, 2, 1, 2], # 0
#   [4, 0, 5, 3, 2, 5, 6, 2, 5, 4], # 1
#   [2, 5, 0, 2, 5, 4, 3, 5, 2, 3], # 2
#   [3, 3, 2, 0, 3, 2, 3, 3, 2, 1], # 3
#   [4, 2, 3, 3, 0, 3, 4, 2, 3, 2], # 4
#   [3, 5, 4, 2, 3, 0, 1, 3, 2, 1], # 5
#   [2, 6, 3, 3, 4, 1, 0, 4, 1, 2], # 6
#   [2, 2, 5, 3, 2, 3, 4, 0, 3, 2], # 7
#   [1, 5, 2, 2, 3, 2, 1, 3, 0, 1], # 8
#   [2, 4, 3, 1, 2, 1, 2, 2, 1, 0], # 9
# ]

SEVEN_SEGMENT_WEIGTH_TRANSITIONS = (0..9).map { |i|
  (0..9).map { |j|
    (SEVEN_SEGMENT_LEDS[i]^SEVEN_SEGMENT_LEDS[j]).to_s(2).chars.map { |c| c.to_i }.sum
  }
}

# pp SEVEN_SEGMENT_WEIGTH_TRANSITIONS

def transition(a, b)
  adigits = a.to_s.chars.map { |c| c.to_i }.reverse
  bdigits = b.to_s.chars.map { |c| c.to_i }.reverse
  ans = 0
  (0...adigits.size).each do |i|
    ans +=  if i >= bdigits.size
              SEVEN_SEGMENT_WEIGTH[adigits[i]]
            else
              SEVEN_SEGMENT_WEIGTH_TRANSITIONS[adigits[i]][bdigits[i]]
            end
  end
  ans
end

# def maxi_b(n)
#   digits = n.to_s.chars.map { |c| c.to_i }
#   new_number = digits.sum
#   if new_number == n
#     0
#   else
#     transition(n, new_number) + (new_number <= 9 ? 0 : maxi_b(new_number))
#   end
# end

def maxi(n : Int32)
  transitions = [] of Int32
  ans = n.to_s.chars.map { |c| SEVEN_SEGMENT_WEIGTH[c.to_i] }.sum
  while n >= 10
    transitions << n
    n = n.to_s.chars.map { |c| c.to_i }.sum
  end
  # pp transitions
  # pp n
  # pp (1...transitions.size).map { |i| transition(transitions[i - 1], transitions[i]) }
  # pp transition(transitions.last, n)
  ans += (1...transitions.size).map { |i| transition(transitions[i - 1], transitions[i]) }.sum
  ans += transition(transitions.last, n) unless transitions.empty?
  ans + SEVEN_SEGMENT_WEIGTH[n]
end

# puts sam(2)
# puts sam(11)
# puts sam(137)

# puts "============================"

# puts transition(137, 11)
# puts transition(11, 2)

# puts "============================"
# puts maxi(2)
# puts maxi(11)
# puts maxi(137)

# puts "============================"
# puts [transition(137, 11), 137.to_s.chars.map { |c| SEVEN_SEGMENT_WEIGTH[c.to_i] }.sum , transition(11, 2), SEVEN_SEGMENT_WEIGTH[2]]
puts input.map { |p| sam(p) - maxi(p) }.sum

