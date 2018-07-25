class P103
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

  def validate(set)
    check([] of Int32, [] of Int32, set)
  end

  N = 50
  K = 7

  def find(set, visited, i)
    return unless validate(set)
    if set.size == K
      s = set.sum
      if s < @best_sum
        @best = set
        @best_sum = s
        puts @best
      end
      return
    end
    (i...N).each do |j|
      next if visited[j]
      v = visited.dup
      (i...N).each do |k|
        break if k + j >= N
        next unless visited[k]
        v[k + j] = true
      end
      find(set + [j], v, j + 1)
    end
  end

  def initialize
    @best_sum = 10000000
    @best = [] of Int32
  end
end
P103.new.find([] of Int32, Array.new(50, false), 1)
