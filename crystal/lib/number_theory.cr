require "big"
# Contains functions that helps on problems about number theory
module NumberTheory
  def phi_e(n, mem = {} of Int64 => Int64)
    return mem[n] if mem.has_key?(n)
    f = factors(n)
        .group_by { |v| v }
        .values
        .map do |r|
          p = r[0]
          s = r.size
          (p - 1) * p**(s - 1)
        end
        .product
    mem[n] = f
  end

  def phi_e(n : T) forall T
    f = factors(n)
        .group_by { |v| v }
        .values
        .map do |r|
          p = r[0]
          s = r.size
          (p - 1) * p**(s - 1)
        end
        .product
    f
  end

  def phi_e(facts : Array(T)) forall T
    facts.group_by { |v| v }
         .values
         .map do |r|
            p = r[0]
            s = r.size
            (p - 1) * p**(s - 1)
          end
         .product
  end


  def factorial_prime_factors(n : T, primes) forall T
    ans = [] of T
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


  def modpow(a : T, b : T,  c : T) forall T
    if b == 0
      T.new(1)
    elsif b == 1
      a
    else
      h = b//2
      t = modpow(a, h, c)
      t * t % c * modpow(a, b % 2, c) % c
    end
  end

  def inv(a : T, b : T) forall T
    modpow(a, b - 2, b)
  end

  def inv_euclid(a : T , b : T) forall T
    d, x, y = extended_euclidean(a.to_big_i, b.to_big_i)
    d == 1 ? (x % b + b) % b : -999999
  end

  def extended_euclidean(a,b)
    return [a, BigInt.new(1), BigInt.new(0)] if b.zero?

    d, x, y = extended_euclidean(b, a % b)
    [d, y , x - BigInt.new(a//b) * y]
  end

  def dividers(n : Int128)
    f = factors(n).group_by { |e| e }
    r = 1_i128
    f.each do |_, k|
      r *= k.size + 1
    end
    r
  end

  def dividers(n : Int64)
    dividers(n.to_i128).to_i164
  end

  def divs_from_factors(n : Int128)
    divs = [1i128]
    factors(n).group_by { |v| v }.to_h { |k, v| { k, v.size } }.each do |p, b|
      divs_2 = [] of Int128
      (0..b).each do |i|
        divs.each do |d|
          divs_2 << d * p ** i
        end
      end
      divs = divs_2
    end
    divs
  end

  def divs_from_factors(n : BigInt)
    divs = [1.to_big_i]
    factors(n).group_by { |v| v }.to_h { |k, v| { k, v.size } }.each do |p, b|
      divs_2 = [] of BigInt
      (0..b).each do |i|
        divs.each do |d|
          divs_2 << d * p ** i
        end
      end
      divs = divs_2
    end
    divs
  end

  def factors(n : T) forall T
    i = T.new(3)
    factors = [] of T
    while n.even?
      factors << T.new(2)
      n = n//2
    end
    while i * i <= n
      while (n % i).zero?
        factors << i
        n //= i
      end
      i += 2
    end
    factors << n unless n == 1
    factors
  end

  def sieve(n)
    sieve = Array.new(n, false)
    sieve[0] = true
    sieve[1] = true

    2.upto((n**0.5).to_i) do |i|
      next if sieve[i]
      (i + i...n).step(i) do |j|
        sieve[j] = true
      end
    end
    primes = (1...n).select { |p| !sieve[p] }
    { primes, sieve }
  end

  def longest_prime_divisor_sieve(n)
    sieve = Array.new(n, false)
    parent = Array.new(n, -1)
    sieve[0] = true
    sieve[1] = true

    (2...n).each do |i|
      next if sieve[i]
      (i + i...n).step(i) do |j|
        sieve[j] = true
        parent[j] = i
      end
    end
    primes = (1...n).select { |p| !sieve[p] }
    { primes, sieve, parent }
  end

  def fermat_prime?(n : T) forall T
    return false if [10, 21, 101].includes?(n)
    modpow(T.new(6), n, n) == 6 || n == 2 || n == 3
  end

  class PrimeTester(T)
    def initialize
      @primes = {} of T => Bool
      @calculated = {} of T => Bool
      @primes[2] = true
      @calculated[2] = true
    end

    def prime?(n)
      return false if n.even? && n != 2
      return false if n < 2
      return @primes[n] if @calculated[n]?
      i = T.new(3)
      @calculated[n] = true
      while i * i <= n
        if n % i == 0
          return @primes[n] = false
        end
        i += 2
      end
      return @primes[n] = true
    end
  end

  class PrimeTesterWithSieve(Int64)
    @primes_list : Array(Int32)

    def initialize(max)
      @primes_list, sieve = sieve(max)

      @primes = {} of Int64 => Bool
      @calculated = {} of Int64 => Bool
      @primes[2] = true
      @calculated[2] = true

      sieve.each_with_index do |e, i|
        @calculated[i.to_i64] = true
        @primes[i.to_i64] = !sieve[i]
      end
    end

    def prime?(n : Int64)
      return false if n.even? && n != 2
      return false if n < 2
      i = 0
      while @primes_list[i].to_i64**2 <= n
        if n % @primes_list[i] == 0
          return @primes[n] = false
        end
        i += 1
      end
      true
    end
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

  def prime_factors_expanded(n : T, primes) forall T
    result = [] of T
    i = 0
    while n > 1
      break if i == primes.size || primes[i]**2 > n
      while i < primes.size && n % primes[i] == 0
        result << primes[i]
        n //= primes[i]
      end
      i += 1
    end
    result << n if n != 1
    result
  end

  def prime_factors_expanded(n : T, primes, sieve : Array(Bool)) forall T
    result = [] of T
    i = 0
    while n > 1
      break if i == primes.size || primes[i]**2 > n
      break if n < sieve.size && !sieve[n]
      while i < primes.size && n % primes[i] == 0
        result << primes[i]
        n //= primes[i]
      end
      i += 1
    end
    result << n if n != 1
    result
  end

  def pollard_rho_prime_factors(n : Int64, fixture = -1)
    x = 2i64
    y = 2i64
    d = 1i64

    result = [] of Int64
    while n > 1
      g = -> (x : Int64) { (x ** 2 + fixture) % n }
      while d == 1
        x = g.call(x)
        y = g.call(g.call(y))
        d = gcd((x - y).abs, n)
      end

      if d == n
        result << d
        return result
      else
        return pollard_rho_prime_factors(n //= d, -fixture) + pollard_rho_prime_factors(d, -fixture)
      end
    end
    result
  end

  def gcd(a, b)
    b == 0 ? a.abs : gcd(b, a % b)
  end

  def lcm(a, b)
    a // gcd(a, b) * b
  end

  def pentagon_number(n : Int64)
    n * (3 * n - 1) / 2
  end

  def triangular_number(n : Int64)
    n * (n + 1) / 2
  end

  def hexagonal_number(n : Int64)
    n * (2 * n - 1)
  end

  def heptagonal_number(n : Int64)
    n * (5 * n - 3) / 2
  end

  def octagonal_number(n : Int64)
    n * (3 * n - 2)
  end

  def binary_search(n, lower = 1_i64, upper = n)
    i = lower
    j = upper
    while i <= j
      k = (i + j) / 2
      fk = yield(k)
      if fk == n
        return true
      elsif fk < n
        i = k + 1
      else
        j = k - 1
      end
    end
    false
  end

  def binary_search_min_true(left : T, right : T) forall T
    last = -1
    while left <= right
      med = (left + right) // 2
      f_med = yield(med)
      if f_med
        left = med + 1
        last = med
      else
        right = med - 1
      end
    end
    last
  end

  def pentagon_number?(n)
    binary_search(n, 1_i64, (n ** 0.7).to_i64) { |x| pentagon_number(x) }
  end

  def triangular_number?(n)
    binary_search(n, 1_i64, (n ** 0.7).to_i64) { |x| triangular_number(x) }
  end

  def hexagonal_number?(n)
    binary_search(n, 1_i64, (n ** 0.7).to_i64) { |x| hexagonal_number(x) }
  end

  def heptagonal_number?(n)
    binary_search(n, 1_i64, (n ** 0.7).to_i64) { |x| heptagonal_number(x) }
  end

  def octagonal_number?(n)
    binary_search(n, 1_i64, (n ** 0.7).to_i64) { |x| octagonal_number(x) }
  end

  def cube_number?(n : BigInt)
    i, j = 1.to_big_i, n
    while i <= j
      k = (i + j) // 2
      f_k = k**3
      if f_k == n
        return true
      elsif f_k > n
        j = k - 1
      else 
        i = k + 1
      end
    end
    false
  end

  def square_number?(n : BigInt)
    i, j = 1.to_big_i, n
    while i <= j
      k = (i + j) // 2
      f_k = k**2
      if f_k == n
        return true
      elsif f_k > n
        j = k - 1
      else 
        i = k + 1
      end
    end
    false
  end
end
