N = 7

list = (1..N).to_a

100.times do 
  puts list
  list = list.map_with_index { |_, k| (list[k-1]-list[k-2]).abs }
end

puts list