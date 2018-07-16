blueprints = File.read_lines("../079.in")
password = blueprints
             .join
             .chars
             .uniq
             .permutations
             .sort
             .select do |s|
               blueprints.all? do |b|
                 s.select { |c| b.includes?(c) }.join == b
               end
             end
puts password.first.join
