require "number_theory"

include NumberTheory

primes, _ = sieve(50 * 10**3)
visited = Array.new(N + 1, false)
N = 50_000_000

primes.each do |a|
  break if a**4 > N
  primes.each do |b|
    sum_1 = a**4 + b**3
    break if sum_1 > N
    primes.each do |c|
      sum_2 = sum_1 + c**2
      break if sum_2 > N
      visited[sum_2] = true
    end
  end
end

puts visited.count { |v| v }
