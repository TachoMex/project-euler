require "big"

def func(blues, disks, total, mem)
  return (blues * 2 > disks ? 1.to_big_i : 0.to_big_i) if disks == total
  if mem[blues][disks] == -1.to_big_i
    x = (disks + 1) * func(blues, disks + 1, total, mem) + func(blues + 1, disks + 1, total, mem)
    mem[blues][disks] = x
  end
  mem[blues][disks]
end

mem = Array.new(100) { Array.new(100, -1.to_big_i) }

N = 15.to_big_i

puts (1.to_big_i..N + 1).product / func(0.to_big_i, 0.to_big_i, N, mem)
