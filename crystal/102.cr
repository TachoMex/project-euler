require "./lib/geometry"

include Geometry

triangles = File.read_lines("../102.in")
                .map do |line|
                  triangle = [] of Point(Int32)
                  line.split(',')
                      .map { |n| n.to_i }
                      .each_slice(2) { |s| triangle << Point.new(s[0], s[1]) }
                  Triangle.new(triangle)
                end

pp triangles.count { |t| t.contains?(Point.new(0, 0)) }
