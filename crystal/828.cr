require "./lib/number_theory"

include NumberTheory

MOD = 1005075251i128
ans = 0i128

def apply(acc : Int32, op : Symbol, num : Int32)
  return -1 if acc == -1 || num == -1
  case op
  when :+
    acc + num
  when :*
    acc * num
  when :- 
    acc > num ? acc - num : -1
  when :/ 
    return nil if num == 0
    acc % num == 0 ? acc // num : -1
  else
    nil
  end 
end

SYMS = [:+, :-, :*, :/]

def eval_ex(seq : Array(Int32)) : Array(Int32)
  if seq.size == 1
    [seq[0]]
  elsif seq.size == 2
    SYMS.map { |s| apply(seq[0], s, seq[1]) }.compact
  else
    acc = [] of Int32
    (1..seq.size).each do |idx|
      left_nums = seq[0...idx]
      right_nums = seq[idx..]
      # puts "Left Nums: #{left_nums}"
      # puts "Right Nums: #{right_nums}"
      next if left_nums.empty? || right_nums.empty?
      left_eval = eval_ex(left_nums)
      next if left_eval.empty?
      right_eval = eval_ex(right_nums)
      next if right_eval.empty?
      SYMS.each do |op|
        left_eval.each_cartesian(right_eval) do |left, right|
          ans = apply(left, op, right)
          acc << ans if ans
        end
      end
    end
    acc.uniq
  end
end

# eval_ex([1, 2, 3, 4, 5], [:+, :*, :-, :/]).each_with_index do |exp, idx|
#   puts "#{idx} => #{exp}"
# end

ans = 0i128
idx = 1i128
File.each_line("./828.in") do |s|
  s = s.split(':')
  target = s[0].to_i
  numbers = s[1].split(',').map(&.to_i)
  best = 999999999
  (1..numbers.size).each do |size|
    numbers.each_permutation(size) do |seq|
      # puts seq if seq.sum == 260 && idx == 43
      next if seq.sum > best
      solutions = eval_ex(seq)
      solutions.each do |acc|
        # puts "#{size} : Trying #{seq} #{ops} => #{acc}" if size == 6
        next if acc != target
        # puts "solution found: #{seq} #{seq.sum} === #{target} <: #{s}"
        best = [best, seq.sum].min
      end
    end
  end
  idx += 1
  next if best == 999999999
  ans = (ans + (modpow(3i128, idx - 1, MOD) * best % MOD)) % MOD
  # puts "#{idx - 1} => #{best} => #{ans}"

end

puts ans % MOD