require "./lib/number_theory"

include NumberTheory

N = 100_000_000_000_000

# primes, sieve = sieve(N + 1)



# harshads = (0..N).map { |x| x > 0 && x % x.to_s.chars.map { |y| y.to_i}.sum == 0 }
# rec_harshads = Array(Bool).new(N + 1, false)

# (1..9).each { |i| rec_harshads[i] = true }
# (10..N).each { |i| rec_harshads[i] = harshads[i] && rec_harshads[i//10] }

# strong_harshads = Array(Bool).new(N + 1, false)
# (1..N).each { |i| strong_harshads[i] = rec_harshads[i] && !sieve[i // i.to_s.chars.map { |y| y.to_i }.sum]}


# puts (0..N).select { |i| harshads[i] }
# puts (0..N).select { |i| rec_harshads[i] }

# set = primes.select { |i| strong_harshads[i//10] }

# puts set
# puts set.sum

def harshads_generator(n, set)
  queue = Deque(Int64).new
  (1i64..9i64).each { |i| queue << i; set << i }

  until queue.empty?
    element = queue.shift
    (0..9).each do |i|
      v = element * 10 + i
      next if v > N
      if v % v.to_s.chars.map { |c| c.to_i}.sum == 0 && !set.includes?(v)
        set << v
        queue << v
      end
    end
  end

  set
end

tester = PrimeTester(Int128).new

harshads_ = Set(Int64).new

harshads_ = harshads_generator(N, harshads_).select { |i| tester.prime?(i // i.to_s.chars.map {|y| y.to_i }.sum) }

solv = [] of Int64

harshads_.each do |h|
  [1, 3, 7, 9].each do |i|
    v = h * 10i64 + i
    solv << v if tester.prime?(v) && v <= N
  end
end

puts solv
puts solv.sum