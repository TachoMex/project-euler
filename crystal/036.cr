puts (1...1_000_000).select { |n| n.to_s == n.to_s.reverse && n.to_s(2) == n.to_s(2).reverse }.sum
