def f(sum : Int64, current : Int64, split, remaining, n)
  # puts({ sum: sum, current: current, remaining: remaining })
  return sum + current.to_i64 == n && split > 1 if remaining.empty?
  h = remaining[0].to_i64
  left = remaining[1..-1]
  f(sum + current, h, split + 1, left, n) || f(sum, current * 10 + h, split, left, n)
end

def s(n : Int64)
  square = n*n
  f(0, 0, 0, square.to_s, n)
end


numbers = (1i64..1_000_000i64).select { |x| s(x) }.map { |x| x * x }
puts numbers.sum
