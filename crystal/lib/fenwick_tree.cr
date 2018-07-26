class FenwickTree
  def initialize(n : Int32, operation : Proc(Int32, Int32, Int32), neutral : Int32 = 0)
    @n = n
    @neutral = neutral
    @bit = Array(Int32).new(n + 1, @neutral)
    @func = operation
  end

  def put(idx, x)
    return if idx == 0
    while idx <= @n
      @bit[idx] = @func.call(x, @bit[idx])
      idx += idx & -idx
    end
  end

  def query(idx)
    answer = @neutral
    while idx > 0
      answer = @func.call(answer, @bit[idx])
      idx -= idx & -idx
    end
    answer
  end
end
