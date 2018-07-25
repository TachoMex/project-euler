def check(a, b, set)
  if set.empty?
    return true if a.empty?
    return true if b.empty?
    a_sum = a.sum
    b_sum = b.sum
    return (a.size >= b.size && a_sum > b_sum) || (a.size <= b.size && a_sum < b_sum)
  end
  tail = set[1..-1]
  check(a, b, tail) && check(a + [set.first], b, tail) && check(a, b + [set.first], tail)
end

result = File.read_lines("../105.in")
             .map { |l| l.split(',').map { |x| x.to_i }}
             .select { |l| check([] of Int32, [] of Int32, l) }
             .flatten
             .sum
puts result
