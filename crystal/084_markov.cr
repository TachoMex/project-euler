exit 0
BOARD = GRAPH.keys

matrix = {} of String => Array(Hash(String, Float64))
markov = Array.new(BOARD.size) { Array.new( BOARD.size, 0.0 ) }

GRAPH.each do |k, v|
  node_k = (BOARD.index(k) || 0)
  (1..N).each do |a|
    (1..N).each do |b|
      (0..2).each do |pairs|
        if pairs == 2 && a == b
          next_ = GRAPH["JAIL"]
        else
          idx = node_k + a + b
          next_ = GRAPH[BOARD[idx % BOARD.size]]
        end
        next_.each do |node, prob|
          markov[node_k][BOARD.index(node) || 0] += 1.0 / prob
        end
      end
    end
  end
end



markov.each_with_index do |row, i|
  total = row.sum
  row.each_with_index do |cell, j|
    markov[i][j] /= total
  end
end
puts "40"
markov.each do |row|
  row.each { |c| print "#{c} " }
  puts
end
