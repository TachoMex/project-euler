N = 2800

primes = [] of Int64
sieve = Array(Bool).new(N + 1, false)
used = Array(Bool).new(N + 1, false)
checked = Array(Bool).new(N + 1, false)
parents = Array(Array(Int64)).new(N + 1) { [] of Int64 }

sieve[0] = sieve[1] = true

sieve.each_with_index do |is_composite, i|
  next if is_composite
  primes << i

  (i..N).step(i).each do |j|
    sieve[j] = true
    parents[j] << i
  end
end

ans = 0.0f64

needed = (3..N).step(10).to_a


needed.each do |x|
  if parents[x].size == 1
    # puts "Only one #{x}"
    checked[x] = true
    ans += Math.log(x)
    used[x] = true
    needed.each { |y| checked[y] = true if y % x == 0}
  end
end

puts ans

needed.reject! { |x| checked[x] }

loop do 
  gives = {} of Int64 => Int64
  
  needed.each do |x|
    next if checked[x]
    
    parents[x].each do |p|
      gives[p] ||= 0
      gives[p] += 1
    end    
  end

  break if gives.empty?
  puts "#{needed.size} are missing"
  p gives
  exit(0)
  p, g = gives.to_a.min_by { |p, g| p }
  puts "Using #{p} which gives #{g}"
  ans += Math.log(p)
  needed.reject! { |x| x % p == 0 }
end


puts ans