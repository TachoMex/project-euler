factorials = (0..9).each_with_object({} of Int32 => Int32) { |n, hash| hash[n] = (1..n).product }

puts (10..999_999).select { |n| n.to_s.chars.map { |i| factorials[i.to_i] }.sum == n }.sum
