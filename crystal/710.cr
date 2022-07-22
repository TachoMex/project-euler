require "big"
def f(n, path, sum)
  # puts "#{n} => #{path} => #{sum} => #{idx}"
  if sum > n
    0i64
  elsif !path.empty? && sum * 2 == n
    puts path + path.reverse
    path.includes?(2) ? 1i64 : 0i64
  elsif !path.empty? && sum * 2 == n + path.last
    puts path + path.reverse[1..-1]
    path.includes?(2) ? 1i64 : 0i64
  else
    (1..n - sum).map do |idx|
      f(n, path.dup.push(idx), sum + idx).as(Int64)
    end.sum
  end
end

def f_without_2(n, sum, last)
  # puts "#{n} => #{path} => #{sum} => #{idx}"
  if sum > n
    0i64
  elsif sum * 2 == n
    1i64
  elsif sum * 2 == n + last
    1i64
  else
    (1..n - sum).map do |idx|
      next 0i64 if idx == 2
      f_without_2(n, sum + idx, idx).as(Int64)
    end.sum
  end
end

def f_with_2(n, sum, last)
  if sum > n
    0i64
  elsif sum * 2 == n
    1i64
  elsif sum * 2 == n + last
    1i64
  else
    (1..n - sum).map do |idx|
      f_with_2(n, sum + idx, idx).as(Int64)
    end.sum
  end
end

# init = [] of Int64
# puts f(20, init, 0)
dp = Array(Int64).new(3, 0)
dp2 = Array(Int64).new(3, 0)
sums = Array(Int64).new(3, 0)
sums2 = Array(Int64).new(3, 0)
dp[0] = 1
dp[1] = 1
dp[2] = 2

sums[0] = 1
sums[1] = 2
sums[2] = 4

dp2[0] = 1
dp2[1] = 1
dp2[2] = 1

sums2[0] = 1
sums2[1] = 2
sums2[2] = 3


MOD = 1_000_000

n = 3
loop do
  n_half = n/2
  n_half_i = n_half.to_i

  dp.push(0)
  dp2.push(0)
  sums.push(0)
  sums2.push(0)

  dp[n] = sums[n - 1]
  dp2[n] = (sums2[n - 1] - dp2[n - 2] + MOD) % MOD

  sums[n] = (sums[n - 1] + dp[n]) % MOD
  sums2[n] = (sums2[n - 1] + dp2[n]) % MOD


  dp_with = sums[n_half_i]
  dp_without = sums2[n_half_i]
  dp_without = (dp_without + MOD - dp2[n_half_i - 1]) % MOD if n.even?
  ans = (dp_with - dp_without + MOD) % MOD

  # rec = f_with_2(n, 0, 0) % MOD
  # rec_2 = f_without_2(n, 0, 0) % MOD

  puts "#{n} => #{dp_with} - #{dp_without} == #{ans}"
  # puts "#{n} => #{rec} - #{rec_2} == #{(rec - rec_2 + MOD) % MOD} R"
  if ans == 0 && n > 42
    break
  end
  n += 1
end


