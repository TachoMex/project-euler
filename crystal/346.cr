require "big"

N = 1_000_000_000_000 #F * F


def rep_units
  ans = [] of Int128
  (2..N).each do |b|
    (2..N).each do |p|
      x = (Int128.new(b) ** (p + 1) - 1)//(b - 1)
      if x > N
        # puts "#{b} break at #{p}"
        return ans if p == 2
        break
      end
      # puts "#{b} ** #{p} = #{x} < #{N}"
      ans << x
    end
  end
  ans
end

puts rep_units.group_by {|x| x }.keys.sum + 1