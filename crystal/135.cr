N = 1000000
T = 10

counts = Array.new(N + 1, 0)

def find_first_positive(x)
  i = 1i128
  j = N.to_i128
  last  = N.to_i128
  while i <= j
    k = (i + j) // 2
    fk = (x+2*k)**2 - (x+k)**2-x**2
    if fk < 0
      i = k + 1
    else
      last = k
      j = k - 1
    end
  end
  last
end

(1i128..N).each do |x|
  puts x if x % 1000 == 0
  b = find_first_positive(x)
  (b..N).each do |r|
    k = (x+2*r)**2 - (x+r)**2-x**2
    break if k >= N
    next if k < 0
    counts[k] += 1
    # puts "#{x} #{r} #{k}"
  end
end

ans = 0

counts.each_with_index do |c, i|
  if c == T
    ans += 1
    puts i
  end
end

puts ans