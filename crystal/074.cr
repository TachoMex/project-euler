FACTORIALS = [1] + (1..9).map { |n| (1..n).product }

def digits_factorials_sum(n)
  n.to_s.chars.map { |c| FACTORIALS[c.to_i] }.sum
end

def chain_size(n, visited, x = 0)
  return x if visited[n]?
  visited[n] = true
  chain_size(digits_factorials_sum(n), visited, x + 1)
end

puts (1..10**6).count { |n| chain_size(n, {} of Int32 => Bool) == 60 }
