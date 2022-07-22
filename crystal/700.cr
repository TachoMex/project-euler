require "big"

def extended_euclidean(a,b)
  return [a, BigInt.new(1), BigInt.new(0)] if b.zero?

  d, x, y = extended_euclidean(b, a % b)
  [d, y , x - BigInt.new(a/b) * y]
end

def inverse(a, p)
  _, x, _ = extended_euclidean(a, p)
  (x + p) % p
end


g = 1504170715041707_i128
mod = 4503599627370517_i128
sum = g
sum_i = 1

g_i = Int128.new(inverse(g, mod).to_i64)
last_i = g_i
last = g

class Generator
  getter g : Int128
  getter p : Int128
  getter coin : Int128
  getter counter : Int128
  def initialize(g, p)
    @g = g
    @p = p
    @coin = 0
    @counter = 0
  end

  def iterate
    @coin += g
    @counter += 1
  end

  def overflow?
    if coin >= p
      @coin -= p
      true
    end
  end
end

seq1 = [[g, 1i128]]
seq2 = [[1i128, g_i]]

gen1 = Generator.new(g, mod)
gen2 = Generator.new(g_i, mod)

loop do
  loop do
    gen1.iterate
    b = gen1.overflow?
    if gen1.coin < last
      seq1 << [gen1.coin, gen1.counter]
      # puts "L#{gen1.coin.to_s.rjust(16, ' ')} => #{gen1.counter.to_s.rjust(16, ' ')}"
      last = gen1.coin
    end
    break if b
  end
  loop do
    gen2.iterate
    b = gen2.overflow?
    if gen2.coin < last_i
      seq2 << [gen2.counter, gen2.coin]
      # puts "R#{gen2.counter.to_s.rjust(16, ' ')} => #{gen2.coin.to_s.rjust(16, ' ')}"
      last_i = gen2.coin
    end
    break if b
  end
  # puts "AT: #{gen1.coin} < #{gen2.counter} && #{gen2.coin} > #{gen1.counter}"
  break if gen1.coin < gen2.counter && gen2.coin > gen1.counter
end

puts (seq1 + seq2).sort { |a, b| a[1] <=> b[1] }.map { |a| "- #{a[0].to_s.rjust(16, ' ')} => #{a[1].to_s.rjust(16, ' ')}"}.join("\n")
puts seq1.size + seq2.size

def seqsum(seq)
  seq.map { |s| s[0] }.sum
end

puts seqsum(seq1) + seqsum(seq2) - 15806432

# sum = 1517926517477964
# last = 258162
# d = (1..258162).map { |ng| [ng, ng * inverse(g, mod) % mod] }.sort { |a, b| a[1] <=> b[1] }.map { |m| m.first}

# d.each do |val|
#   next if val > last
#   last = val
#   sum += val
#   puts "#{val} => #{sum}"
# end


# puts sum