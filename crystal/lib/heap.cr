class Heap(T, V)
  class Pair(T, V)
    @priority : T
    @value : V

    getter priority : T
    getter value : V

    def initialize(p : T, v : V)
      @priority = p
      @value = v
    end

    def <(other : self)
      @priority < other.priority
    end

    def <=(other : self)
      @priority <= other.priority
    end

    def >(other : self)
      @priority > other.priority
    end

    def unwrap
      { @priority, @value }
    end

    def clone
      Pair(T, V).new( @priority.clone, @value.clone )
    end
  end

  @heap : Array(Pair(T, V))
  def initialize
    @heap = [] of Pair(T, V)
  end

  def empty?
    @heap.empty?
  end

  def size
    @heap.size
  end

  def to_a
    @heap.clone
  end

  def push(p : T, v : V)
    data = Pair(T, V).new(p, v)
    @heap << data
    i = @heap.size
    while i > 1 && @heap[i // 2 - 1] > @heap[i - 1]
      @heap[i // 2 - 1], @heap[i - 1] = @heap[i - 1], @heap[i // 2 - 1]
      i //= 2
    end
  end

  def pop
    ans = @heap.first
    @heap[0] = @heap[-1]
    @heap.pop
    i = 1
    while i <= @heap.size
      left = i * 2
      right = left + 1
      has_left = left <= @heap.size
      has_right = right <= @heap.size
      break unless has_left
      left_val = @heap[left - 1]
      if has_right
        right_val = @heap[right - 1]
        if left_val < right_val && @heap[i - 1] > left_val
          @heap[left - 1], @heap[i - 1] = @heap[ i - 1], left_val
          i = left
        elsif @heap[i - 1] > right_val
          @heap[right - 1], @heap[i - 1] = @heap[i - 1], right_val
          i = right
        else
          break
        end
      elsif has_left && left_val < @heap[i - 1]
        @heap[left - 1], @heap[i - 1] = @heap[i - 1], left_val
        i = left
      else
        break
      end
    end
    ans
  end
end
