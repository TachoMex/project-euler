r = (1..10).to_a
          .permutations
          .select do |ring|
            [3, 5, 7, 9].all? { |p| ring[p] > ring[1] }
          end
          .map do |p|
             [[p[1], p[0], p[2]],
              [p[3], p[2], p[4]],
              [p[5], p[4], p[6]],
              [p[7], p[6], p[8]],
              [p[9], p[8], p[0]]]
          end
          .select do |ring|
            ring.all? { |side| side.sum == ring[0].sum }
          end
          # .map { |ring| ring.map { |side| side.join(',') }.join('|') }
          .map { |ring| ring.flatten.join }
          .select { |str| str.size == 16 }
          .max
puts r
