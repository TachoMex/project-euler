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

  def factors(n : Int64)
    factors(n.to_i64).map { |x| x.to_i64 }
  end

  def factors(n : Int128)
    i = 3_i128
    factors = [] of Int128
    while n.even?
      factors << 2_i128
      n /= 2
    end
    while i * i <= n
      while (n % i).zero?
        factors << i
        n /= i
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

    2_i64.upto((n**0.5).to_i) do |i|
      next if sieve[i]
      (i + i...n).step(i) do |j|
        sieve[j] = true
      end
    end
    primes = (1...n).select { |p| !sieve[p] }
    { primes, sieve }
  end

  class PrimeTester
    def initialize
      @primes = {} of Int32 => Bool
      @calculated = {} of Int32 => Bool
      @primes[2] = true
      @calculated[2] = true
    end

    def prime?(n)
      return false if n.even? && n != 2
      return false if n < 2
      return @primes[n] if @calculated[n]?
      i = 3
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

  def square_number?(n)
    (n ** 0.5).to_i ** 2 == n
  end
end
