def f(i, n)
  return 0 if i > n
  # puts "#{i.to_s.rjust(3)} #{i.to_s(2).rjust(8)}"
  i + f(i * 2, n) + f(i * 4 + 1, n)
end

# puts (1..1024).select { |a| a^(2*a)^(3*a) == 0 }.map { |a| "#{a.to_s.rjust(3)} #{a.to_s(2).rjust(8) }" }.join("\n")
# puts (1..1024).select { |a| a^(2*a)^(3*a) == 0 }.sum # map { |a| "#{a.to_s.rjust(3)} #{a.to_s(2).rjust(8) }" }.join("\n")
# puts (1..1024).reject { |i| i.to_s(2).includes?("11") }.sum # map { |a| "#{a.to_s.rjust(3)} #{a.to_s(2).rjust(8) }" }.join("\n")
# puts f(1i64, 10124)
puts (1i64..2i64**30).count { |a| a^(2i64*a)^(3i64*a) == 0 }