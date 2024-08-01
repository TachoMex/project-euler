require "./lib/number_theory"
include NumberTheory

N = 100_000_000

primes, sieve = sieve(N + 1)

pi = [0] * (N + 1)
c = [0] * (N + 1)
# seqs = Array.new(N + 1) { Array(Int32).new }
sum = 0

ps = [0] * (N + 1)

def seq(n, pi)
  ans = [] of Int32
  while n > 0
    ans << n
    n = pi[n]
  end
  ans.reverse
end

def count_seqs(seqi)
  (2..seqi.size).each do |j|
    sq = seqi[-j..-1]
    yield(sq)
  end
end

ans = 1i128

(0..N).each do |i|
  puts "Processing #{i}" if i % 10000 == 0
  sum += 1 unless sieve[i]
  pi[i] = sum
  seqi = seq(i, pi)
  count_seqs(seqi) do |sq|
    not_primes = sq.count { |e| sieve[e] }
    ps[not_primes] += 1 if not_primes
    # puts "#{sq} has #{not_primes}=c[u]"
  end
end


# p sieve
# p primes
# p pi
# pp seqs
# p ps
# count_seqs([1, 2, 3, 4]) { |y| puts "Yielding: #{y}"}
puts ps.select { |a| a > 0 }.reduce { |a, b| a.to_i128 * b.to_i128  % 1000000007 }