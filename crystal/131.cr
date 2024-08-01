#n²(n + p)
#n + p is a cube
#n² is a cube


require "number_theory"
include NumberTheory

N = 1_000_000

primes, _ = sieve(N)
cubes_and_squares = (1i128..N)
                      .map { |n| n.to_big_i**3 }
                      .map { |n| {n, n.to_big_i**2} }
ans = 0

primes.each do |p|

end

cubes_and_squares.each do |n, _|
  primes.each do |p|
    if cube_number?(n.to_big_i + p)
      ans += 1
      puts "p: #{p} n: #{n} #{ans}"
    end
  end
end

# puts "-" * 40
# primes.each do |p|
#   cubes.each do |c|
#     n = (c - p).to_big_i
#     if cube_number?(n*n) && n > 0
#       puts "p: #{p} n: #{n} #{n**3 + p*n**2}"
#       ans += 1
#     end
#   end
# end


puts ans