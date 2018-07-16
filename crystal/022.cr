names = File
        .read("../022.in")
        .strip
        .tr("\"", "")
        .split(',')
        .sort
        .map_with_index { |s, i| (i + 1) * s.chars.map { |c| c.ord - 64 }.sum }
        .sum
puts names
