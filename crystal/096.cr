class Sudoku
  getter :grid
  @grid : Array(Array(Int32))
  @counts_h : Array(Array(Array(Int32)))
  @counts_v : Array(Array(Array(Int32)))
  @counts_g : Array(Array(Array(Int32)))


  def initialize(grid : Array(String))
    @counts_v = Array.new(10) { Array.new(10) { Array.new(10, 0) } }
    @counts_h = Array.new(10) { Array.new(10) { Array.new(10, 0) } }
    @counts_g = Array.new(10) { Array.new(10) { Array.new(10, 0) } }
    @grid = Array.new(10) { Array.new(10, 0) }

    (0...9).each do |i|
      (0...9).each do |j|
        put_number(i + 1, j + 1, grid[i][j].to_i) if grid[i][j] != '0'
      end
    end
  end

  def put_number(i, j, a)
    @grid[i][j] = a
    (1..9).each do |k|
      @counts_h[i][k][a] += 1
      @counts_v[k][j][a] += 1
    end

    x = i - ((i - 1) % 3)
    y = j - ((j - 1) % 3)
    (0..2).each do |p|
      (0..2).each do |q|
        @counts_g[x + p][y + q][a] += 1
      end
    end
  end

  def remove_number(i, j, a)
    @grid[i][j] = 0
    (1..9).each do |k|
      @counts_h[i][k][a] -= 1
      @counts_v[k][j][a] -= 1
    end

    x = i - ((i - 1) % 3)
    y = j - ((j - 1) % 3)
    (0..2).each do |p|
      (0..2).each do |q|
        @counts_g[x + p][y + q][a] -= 1
      end
    end
  end

  def find(i, j)
    return true if j == 10
    next_i = i + 1
    next_j = j
    if i == 9
      next_i = 1
      next_j = j + 1
    end
    return find(next_i, next_j) if @grid[i][j] != 0
    (1..9).each do |k|
      if @counts_g[i][j][k] + @counts_v[i][j][k] + @counts_h[i][j][k] == 0
        put_number(i, j, k)
        return true if find(next_i, next_j)
        remove_number(i, j, k)
      end
    end
  end

  def solve
    find(1, 1)
  end

  def show
    (1..9).each do |i|
      (1..9).each do |j|
        print "#{@grid[i][j]} "
        print "| " if j % 3 == 0 && j != 9
      end
      puts
      puts "------+-------+------" if i % 3 == 0 && i != 9
    end

    puts ""
  end

  def self.read(file)
    file.read_line
    new((1..9).map { file.read_line.strip })
  end

  def check_code
    @grid[1][1] * 100 + @grid[1][2] * 10 + @grid[1][3]
  end
end

file = File.open("../096.in")
sum = 0

(1..50).each do
  sudoku = Sudoku.read(file)
  sudoku.solve
  sum += sudoku.check_code
end

puts sum
