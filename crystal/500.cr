require "./lib/number_theory"
require "./lib/heap"


include NumberTheory

N = 500500i128
MOD = 500500507i64

# queue = Heap(Float64, Int32).new
queue = Heap(BigInt, Tuple(Int32, Int32)).new

primes, sieve = sieve(7400000)

vector = primes.map { 0 }

primes.each do |p|
  queue.push(p.to_big_i, { p, 1 } )
end

ans = BigInt.new(1)
N.times do
  multiplicator, tuple = queue.pop.unwrap
  p, power = tuple
  new_power = (power) * 2 + 1 # 0 => 1 => 3 => 7 = 15
                              # 1 => 2 => 8 => 128 => 32768
  ans *= multiplicator
  ans %= MOD
  new_factor = BigInt.new(p) ** (new_power - power)
  new_tuple = { p, new_power }
  # vector[primes.index { |q| q == p }.as(Int32)] = power

  # puts "Multiplying by #{multiplicator}"
  # puts "Exponent for #{p} set to #{power}"
  # puts "Next muptiplicator #{new_factor}"

  queue.push(new_factor, new_tuple)
  # # puts vector
  # # puts "============================"
end
puts ans
puts ans % MOD
# puts vector.reject {|v| v.zero?}.zip(primes).map { |a, b| b.to_big_i**(a - 1) }.reduce { |a, b|  a * b  }
# puts vector.reject {|v| v.zero?}.zip(primes).map { |a, b| b.to_big_i**(a - 1) }.reduce { |a, b|  a * b % MOD }

