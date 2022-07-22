require "./lib/number_theory"

include NumberTheory

F = 1000000i64
N = F * F * F


primes, _ = sieve(F + 1)

powers = [] of Int64

primes.each do |p|
  power = p.to_i128 ** 3i64
  while power <= N
    # puts "#{p} => #{power}"
    powers << power.to_i64
    power *= p
  end
end

sum = N

powers.sort!
# puts powers

def f(n, i, powers)
  sum = 0i64
  (i + 1...powers.size).each do |j|
    pj = powers[j]
    m = pj.to_i128 * n
    return sum if m > N
    gj = gcd(n, pj)

    sum += N // m.to_i64 if gj == 1
    sum += f(m, j, powers).as(Int64) if gj == 1
  end
  sum
end

powers.each_with_index do |p1, i|
  sum += N // p1
  sum += f(p1.to_i128, i, powers)
  # (i + 1...powers.size).each do |j|
  #   p2 = powers[j]
  #   n = p1.to_i128 * p2
  #   break if n > N
  #   g = gcd(p1, p2)
  #   # puts "power: #{p1} #{p2} #{n} #{N // n} #{g}" unless g == 1

  #   (j + 1...powers.size).each do |k|
  #     p3 = powers[k]
  #     m = n * p3
  #     break if n > N
  #     g2 = gcd(n, p3)

  #     sum += N // m unless g2 != 1
  #   end

  #   sum += N // n unless g != 1
  # end
end

puts sum
