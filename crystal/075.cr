ans = 1
N = 1_500_000
n = 10_000
visited = Array.new(N + 1, 0)


(1..n).each do |m|
  (1..m).each do |n|
    next if m.gcd(n) != 1
    next if m.odd? && n.odd?
    a = m**2 - n**2
    b = 2 * m * n
    c = m**2 + n**2
    l = a + b + c
    i = l
    loop do
      break if i > N
      visited[i] += 1
      i += l
    end
  end
end

puts visited.count { |x| x == 1 }
