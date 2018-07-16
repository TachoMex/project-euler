parents = Array.new(10**8, -1)
parents[1] = 1
parents[89] = 89

def dfs(n, parents)
  if parents[n] == -1
    parent = n.to_s.chars.map { |x| x.to_i**2 }.sum
    parents[n] = dfs(parent, parents)
  end
  parents[n]
end

puts (1..10**7).count { |i| dfs(i, parents) == 89 }
