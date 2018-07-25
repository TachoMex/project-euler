N = 12

strings = (0..(3**N)).map { |i| i.to_s(3) }
                       .reject { |s| !s.includes?('1') }
                       .reject { |s| !s.includes?('2') }
                       .select do |s|
                         ones = [] of Int32
                         twos = [] of Int32
                         s.chars.each_with_index do |e, i|
                           case e
                           when '1'
                             ones << i
                           when '2'
                             twos << i
                           end
                         end
                         unless ones.size == twos.size
                           false
                         else
                           ones_bigger = 0
                           twos_bigger = 0
                           ones.each_with_index do |o, i|
                             if o < twos[i]
                               twos_bigger += 1
                             else
                               ones_bigger += 1
                             end
                           end
                           ones_bigger != 0 && twos_bigger != 0
                         end
                       end


pp strings.size / 2
