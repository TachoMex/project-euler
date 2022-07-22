require "./lib/number_theory"
include NumberTheory

N = 10_000_000i64

primes, sieve = sieve(N + 1)

# def m(p, q, n, primes)
#   leftp = 1
#   rightp = 32
#   ans = 0i128
#   while leftp <= rightp
#     midp = (leftp + rightp) // 2
#     pp = (p ** midp).to_big_i
#     lastq = -1i128
#     if pp < n
#       leftq = 1i128
#       rightq = 32
#       k = -1i128
#       while leftq <= rightq
#         midq = (leftq + rightq) // 2

#         qq = (q ** midq).to_big_i

#         if qq < n
#           k = pp * qq
#           if k <= n
#             lastq = Math.max(k, lastq)
#             leftq = midq + 1
#           else
#             rightq = midq - 1
#           end
#         else
#           rightq = midq - 1
#         end
#       end
#       if lastq != -1
#         ans = Math.max(ans, lastq )
#         leftp = midp + 1
#       else
#         rightp = midp - 1
#       end
#     else
#       rightp = midp - 1
#     end
#   end
#   ans
# end

def m(p, q, n, primes)
  ans = 0i128
  pp = p
  while pp < n
    qq = q
    while qq < n
      k = pp * qq
      if k <= n
        ans = Math.max(k, ans)
      else
        break
      end
      qq *= q
    end
    pp *= p
  end
  raise "kk" if ans == 0
  ans
end

sum = 0i128

primes = primes.map { |p| BigInt.new(p) }

primes.each_with_index do |p, idx|
  break if p * primes[idx] + 1 > N
  puts p
  (idx + 1...primes.size).each do |idx2|
    q = primes[idx2]
    pq = p * q
    break if pq > N

    pqq = q.to_big_i * p.to_big_i ** 2i128

    s = Math.max(m(p.to_big_i, q.to_big_i, N, primes), m(q.to_big_i, p.to_big_i, N, primes))
    puts({s, p, q}) if idx2 % 100000 == 0
    sum += s if s
  end
  puts "#{sum} #{idx}/#{primes.size}"
end

puts sum
