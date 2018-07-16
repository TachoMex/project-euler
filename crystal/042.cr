triangulars = (0..100).map{ |n| (1..n).sum }

words = File
        .read("../042.in")
        .strip
        .tr("\"", "")
        .split(',')
        .sort
        .select do |word|
          triangulars.includes? word.chars.map { |c| c.ord - 64 }.sum
        end
puts words.size
