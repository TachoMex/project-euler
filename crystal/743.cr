def f(n, k)
  total = 0
  ones_a = [] of Int32
  [0, 1, 2].each_repeated_permutation(n) do |comb|
    sums = Array(Int64).new(n, 0)
    sums[0] = comb[0]
    (1...n).each { |idx| sums[idx] = sums[idx - 1] + comb[idx]}
    valid = (k...n).all? do |i|
      # puts "sums[i=#{i}]=#{sums[i]} - sums[i-k=#{k}-1]=#{sums[i - k]} = #{sums[i] - sums[i - k]}"
      sums[i] - sums[i - k] == k
    end && sums[k - 1] == k
    ones = comb.count(1)
    puts "#{comb} => #{valid} => ones = #{ones}" if valid
    total += 2**ones if valid
    ones_a << ones if valid
  end
  # puts ones_a.group_by { |i| i }.to_h { |k, v| {k, v.size} }
  puts total
end

def f2_rec(n, k, ones)
  if n == 0
    2**ones
  elsif k == 0 || n.negative?
    0
  else
    f2_rec(n, k-1, ones) + f2_rec(n-1, k-1, ones+1) + f2_rec(n-2, k-1, ones)
  end
end

def f2(n)
  f2_rec(n, n, 0)
end

def pow(a, b, c)
  if b == 0
    1i64
  elsif b == 1
    a.to_i64
  else
    h = (b/2).to_i64
    t = pow(a, h, c)
    t * t % c * pow(a, b % 2, c) % c
  end
end

def pow(a : BigInt, b : BigInt, c : BigInt)
  if b == 0
    BigInt.new(1)
  elsif b == 1
    BigInt.new(a)
  else
    h = BigInt.new(b/2)
    t = pow(a, h, c)
    t * t % c * pow(a, b % 2, c) % c
  end
end

def inv(a, p)
  pow(a, p - 2, p)
end

MOD = 1_000_000_007i64

FACTORIALS = (1i64..100_000_000i64).each_with_object(Array(Int64).new(100_000_001, 1i64)) { |i, objct| objct[i] = i * objct[i-1i64] % MOD; objct }

def f3(n, k)
  raise "lol" if k < n
  parity = n % 2
  result = 0i64
  ratio = (k / n).to_i64
  (parity..n).step(2).each do |ones|
    twos = ((n - ones + parity)/ 2).to_i64
    puts "#{n} => #{ones} #{twos} = #{ones+2*twos}"
    invftwos=inv(FACTORIALS[twos], MOD)
    result = (result + inv(FACTORIALS[ones], MOD) * invftwos % MOD * invftwos % MOD  * pow(2, ones * ratio, MOD)) % MOD
  end
  result * FACTORIALS[n] % MOD
end

def f4(n, k)
  frequencies = Array(Int64).new(0, n)
  parity = n % 2
  result = 0i64
  ratio = (k / n).to_i64
  (parity..n).step(2).each do |ones|
    twos = ((n - ones + parity)/ 2).to_i64
    puts "#{n} => #{ones} #{twos} = #{ones+2*twos}"
    invftwos=inv(FACTORIALS[twos], MOD)
    result = (result + inv(FACTORIALS[ones], MOD) * invftwos % MOD * invftwos % MOD  * pow(2, ones * ratio, MOD)) % MOD
  end
  result * FACTORIALS[n] % MOD
end

puts f3(100_000_000i64, 10_000_000_000_000_000)