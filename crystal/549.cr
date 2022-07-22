require "./lib/number_theory"
include NumberTheory

F = 10i64
N = F * F

primes, sieve = sieve(N + 1)

def factor_vector_add(a, b)
  c = Array(Int32).new(Math.max(a.size, b.size), 0)
  a.each_with_index { |v, i| c[i] += v}
  b.each_with_index { |v, i| c[i] += v}
  c
end

def factorial_prime_factors(n, primes)
  # puts "Calculating #{n}"
  ans = [] of Int32
  i = 0
  while i < primes.size && primes[i] <= n
    count = 0
    t = n
    while t > 0
      count += t // primes[i]
      t //= primes[i]
    end
    ans << count
    i += 1
  end
  ans
end

def prime_factors(n, primes)
  result = [] of Int32
  i = 0
  while n > 1
    count = 0
    while n % primes[i] == 0
      count += 1
      n //= primes[i]
    end
    i += 1
    result << count
  end
  result
end


factorials = (0..F).map { |i| factorial_prime_factors(i, primes) }

# def bf(n, sieve)
#   return n if !sieve[n]
#   idx = 1i64
#   fact = 1i64

#   while fact % n != 0
#     fact = (fact * idx) % n
#     idx += 1
#   end

#   return idx - 1
# end

def f(n, sieve, primes, factorials, memory)
  return n if !sieve[n]
  needed = prime_factors(n, primes)
  # puts needed
  max = 0
  needed.each_with_index do |b, i|
    next if b == 0
    memory[i] = Hash(Int32, Int32).new unless memory.has_key?(i)
    if memory[i].has_key?(b)
      max = Math.max(memory[i][b], max)
      next
    elsif primes[i] > F
      # puts "#{n} ::: #{primes[i]} #{b}"
      max = Math.max(primes[i] * b, max)
      next
    end
    left = 0
    right = F
    last = -1
    while left <= right
      med = (left + right) // 2
      f_med = i >= factorials[med].size ? -1 : factorials[med][i]
      if f_med >= b
        last = med
        right = med - 1
      else
        left = med + 1
      end
    end
    last = primes[i] * b if last == -1
    memory[i][b] = last

    max = Math.max(max, last)
  end
  max
end

memory = Hash(Int32, Hash(Int32, Int32)).new

# solutions = [] of Int64

# max_compose = 0i64

cool = (2i64..N).map do |i|
  x = f(i, sieve, primes, factorials, memory)
  # y = bf(i, sieve)
  # puts "#{i} => #{x} <= #{y}" if x != y
  puts "#{i} :: #{x}"
  # max_compose = Math.max(max_compose, x) if sieve[x]
  # solutions << x.to_i64
  BigInt.new(x)
end.sum

# primes_til_half = primes.select { |p| 2 * p <= N }
# primes_til_half2 = primes.select { |p| 2 * p > N }

# primes_til_sqrt = primes.select { |p| p <= F }
# primes_til_sqrt2 = primes.select { |p| p > F }

# ans = BigInt.new(0)
# primes_til_sqrt2.each { |p| ans += N // p * p }
# ans += primes_til_sqrt.sum


# top = primes_til_sqrt[0] * primes_til_sqrt[-1]
# puts top

# (3..top).each do |n|
#   idx = 1i64
#   while idx * idx <= fact && (sieve[n] || n <= F)
#     if fact % idx == 0
#       p = fact // idx
#       q = fact // p
#       p *= n
#       q *= n
#       if p <= N && !rifa.includes?(p)
#         rifa << p.to_i64
#         puts "#{n} => #{p}"
#         ans += n
#       end
#       if q <= N && q != p && !rifa.includes?(q)
#         rifa << q.to_i64
#         puts "#{n} => #{q}"
#         ans += n
#       end
#     end
#     idx += 1
#   end
#   fact *= n
# end


# # puts solutions
# puts solutions.sort.select { |p| primes_til_sqrt2.none? { |q| p % q == 0 } }.group_by { |v| v }.to_h { |k, v| {k, v.size }}
# # puts solutions.sort.select { |p| primes_til_sqrt2.none? { |q| p % q == 0 } }.group_by { |v| v }.map { |k, v| k * v.size }.sum
# # puts primes_til_sqrt

# (2..top).reverse_each do |i|
#   next unless sieve[i]
#   x = f(i, sieve, primes, factorials, memory)
#   puts "#{i} => #{x}"
#   ans += x
# end

puts cool
# puts ans
# puts cool - ans
# # puts max_compose
# # puts solutions.select {|i| sieve[i]}
# puts solutions.map_with_index { |a, i| { a, i + 2 } }.select { |a, b| sieve[a] }.sort.join('\n')

# puts (1..N).reject { |i| rifa.includes?(i) || primes.includes?(i) }
# puts rifa

# puts memory.map { |k, v|
#   "#{k}<: #{v}"
# }.join("\n")
