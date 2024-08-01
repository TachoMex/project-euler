N = 7

visited = Array(Array(Bool)).new(2 * N + 1) { Array(Bool).new(2 * N + 1, false) }

def bf(pa, pb, n, visited)
  if pa < pb
    0
  elsif n == 0
    return 0 if visited[pa][pb]
    puts [pa, pb]
    visited[pa][pb] = true
    1
  else
    bf(pa + 2, pb, n - 1, visited) + 
    bf(pa, pb + 2, n - 1, visited) + 
    bf(pa + 1, pb + 1, n - 1, visited)
  end
end

puts bf(0, 0, N, visited)