require "math"

lines = File.read_lines("../099.in")
            .map { |row| row.split(',') }
            .map { |row| row[1].to_f64 * Math.log(row[0].to_f64) }

puts (lines.index(lines.max) || 0) + 1
