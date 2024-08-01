# N = 1000_000_00i128
N = 100000000i128

def palindrome?(n)
  n.to_s == n.to_s.reverse
end

palindromics = Set(Int128).new
squares = [] of Int128

i = 1
while i**2 <= N
  squares << i**2
  i += 1
end

(0...squares.size).each do |a|
  sum = squares[a]
  (a+1...squares.size).each do |b|
    sum += squares[b]
    break if sum > N
    palindromics << sum
  end
end

palindromics = palindromics.to_a.sort

puts palindromics.select { |p| p <= N && palindrome?(p) }
puts palindromics.select { |p| p <= N && palindrome?(p) }.size
puts palindromics.select { |p| p <= N && palindrome?(p) }.sum
