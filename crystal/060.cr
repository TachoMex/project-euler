require "./lib/number_theory"

include NumberTheory
N = 10_000

def fits?(set, p)
  return if set.any? { |q| q >= p }
  prime_test = PrimeTester.new
  set.all? do |q| prime_test.prime?([p, q].join.to_i) &&
                    prime_test.prime?([q, p].join.to_i)
  end
end

def iterate(collection, primes)
  result = [] of Array(Int32)
  collection.each do |set|
    primes.each do |p|
      result << set + [p] if fits?(set, p)
    end
  end
  result
end

primes, sieve =  sieve(N)
# initial_set = [3, 7, 109, 673]
seconds = iterate(primes.map { |p| [p] }, primes)
thirds = iterate(seconds, primes)
fourths = iterate(thirds, primes)
fifths = iterate(fourths, primes)
puts fifths.min_by { |e| e.sum }.sum
