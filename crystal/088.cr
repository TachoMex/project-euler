require "./lib/number_theory"

include NumberTheory

K = 12000

n = 24000
minimums = {} of Int32 => Int32
combs = {} of Int32 => Set(Int32)

(2..n).each do |i|
  combs[i] ||= Set(Int32).new
  combs[i] << 1
  (1...i).each do |p|
    break if i / p > i
    next if i % p != 0
    k = i - p - i / p
    # puts "#{i} = #{p} x #{i/p} => #{k}"
    if k + 2 <= K && k >= 0
      minimums[k + 2] ||= i
      combs[i] << k + 2
      combs[p]? && combs[p].each do |a|
        combs[i/p]? && combs[i/p].each do |b|
          k_2 = k + a + b
          minimums[k_2] ||= i if k_2 <= K
          combs[i] << k_2
        end
      end
    end
  end
end

puts minimums.values.uniq.sum
