require "./lib/number_theory"

include NumberTheory

N = 1_000_000_000_000

numbers = Set(Int128).new


a = 0
loop do
  x = 5i128**a
  break if x > N
  b = 0
  loop do
    y = 3i128**b
    break if x * y > N
    c = 0
    loop do
      z = 2i128**c
      n = x * y * z
      break if n > N
      numbers << n
      c += 1
    end
    b += 1
  end
  a += 1
end

ans = 0i128
tester = PrimeTester(Int128).new

numbers.clone.each do |p|
  next if p <= 5
  # next unless fermat_prime?(p + 1)
  next unless tester.prime?(p + 1)
  break if p >= N
  # puts "found prime #{p + 1}"
  new_numbers = [] of Int128
  numbers.each do |q|
    n = (p + 1) * q
    new_numbers << n if n <= N
  end
  numbers += Set.new(new_numbers)
end
ans = numbers.sum


puts ans % (2i128**32)
# p numbers
# p extra_numbers

# puts ans
# f(1_000_000)
# 15121373665
# 40716
# 10**8 => 17999533584045
# 10**9 => 575728445129130
# 10**12 =>
