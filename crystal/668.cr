require "./lib/number_theory"

include NumberTheory

F = 100000i128
N = F * F

sieve = Array.new(F + 1, -1)

2.upto(F) do |i|
  next if sieve[i] != -1
  (i + i..F).step(i) do |j|
    sieve[j] = i
  end
end
primes = (2..F).select { |p| sieve[p] == -1 }

# p primes
# used = Set(Int64).new

sum = 1i64
sum2 = 1i64
# sum = 2795444534i64


mem = {} of Int128 => Int128

# primes.reverse.each do |p|
#   q = p.to_i128 * (p + 1)

#   while q <= N
#     k = q // p
#     puts k
#     max_factor = if mem.has_key?(k)
#                    mem[k]
#                  else
#                    mem[k] = prime_factors_expanded(k, primes, sieve).max
#                    mem[k]
#                  end
#     if max_factor <= p
#       sum += 1
#     end
#     q += p
#   end
#   puts "#{p} => #{sum}"
# end
# puts sum + 1

# def rec(k, maxp, idx, taken, primes)
#   return 0 if k > N || idx >= primes.size
#   ans = 0i64
#   ans += 1 if !taken && Math.sqrt(k.to_f64) > maxp
#   ans + rec(k * primes[idx], Math.max(maxp, primes[idx]), idx, false, primes) + rec(k, maxp, idx+1, true, primes);
# end

# puts rec(1i128, 1i128, 0i128, false, primes) + 1
# used.to_a.sort


def calc_lower(primes, max_factor)
  lower = primes.size
  left = 0
  right = primes.size - 1
  while left <= right
    med = (left + right) // 2
    p = primes[med]
    if p < max_factor
      left = med + 1
    else
      right = med - 1
      lower = med
    end
  end
  lower
end

def calc_upper(primes, k)
  upper = primes.size
  left = 0
  right = primes.size - 1
  while left <= right
    med = (left + right) // 2
    p = primes[med].to_i128
    # puts "#{left} #{med} #{right} | #{p} >> #{p * k} > #{N}" if k == 4 || k == 6k
    if p * k > N || k <= p
      right = med - 1
      upper = med
    else
      left = med + 1
    end
  end
  upper
end


(2i128..N//3).each do |k|
  result = 1
  i = 0
  n = k
  upper = calc_upper(primes, k)
  while n > 1 && i < primes.size
    break if n < sieve.size && sieve[n] == -1
    break if primes[i].to_i64**2 > n
    break if i >= upper
    if n <= F
      result = Math.max(result, sieve[n])
      n //= sieve[n]
    else
      while n % primes[i] == 0
        result = Math.max(result, primes[i])
        n //= primes[i]
      end
      i += 1
    end
  end

  result = Math.max(n, result) if n != 1

  max_factor = result
  next if max_factor > F

  # selected = primes.select do |p|
  #   p * k <= N && k > p && max_factor <= p
  # end

  # selected = [] of Int128
  # primes.each do |p|
  #   # puts "testing #{p}" if (k == 4 || k == 6)
  #   # puts "mf:#{max_factor} p: #{p} k: #{k} pk: #{p * k}" if k == 4 || k == 6
  #   # puts "break because #{p*k} > N" if p * k > N && (k == 4 || k == 6)
  #   break if p * k > N || k <= p
  #   # puts "Skipping because #{p} < #{max_factor} p < max_factor" if (k == 4 || k == 6) && p < max_factor
  #   # puts "Skipping because #{k} <= #{p} k <= p" if (k == 4 || k == 6) && k <= p
  #   next if p < max_factor
  #   selected << p
  # end
  # sum += selected.size
  lower = calc_lower(primes, max_factor)
  # puts "#{lower} .. #{upper}"
  # upper ||= primes.size
  # sum += selected.size
  sum2 += upper - lower if lower < upper
  # puts "#{k} => #{sum} :: #{selected} :: #{lower}..#{upper} #{primes[lower...upper]}" if primes[lower...upper] != selected

  puts "#{k} #{sum2}" if k % 1_000_000 == 0
  # sum += upper - lower
end
# puts sum
puts sum2 + 1

# pp pairs

# ans = [1] of Int32
# (2..N).each do |n|
#   puts n/N*100 if n % 100_000 == 0
#   sqrt = (n**0.5)

#   result = 1
#   i = 0
#   while n > 1 && i < primes.size
#     break if n < sieve.size && !sieve[n]
#     break if primes[i]**2 > n
#     while n % primes[i] == 0
#       result = Math.max(result, primes[i])
#       n //= primes[i]
#     end
#     i += 1
#   end
#   result = Math.max(n, result) if n != 1
#   ans << n if result < sqrt

#   # ans << n if pollard_rho_prime_factors(n).max < sqrt
# end
# p ans
# p ans.size
# p ans.map{ |i| pollard_rho_prime_factors(i) }# .flatten.uniq
# 2:29
# 3:274
# 4:2656
# 5:26613
# 6:268172
# 7:2719288
# 8:27531694
# 10:
