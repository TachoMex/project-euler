class Matrix
  def initialize(matrix : Array(Array(Float64)))
    @matrix = matrix
  end

  def raw
    @matrix.clone
  end

  def size
    @matrix.size
  end

  def multiply_row(r, x)
    (0...@matrix.size).each { |i| @matrix[r][i] *= x }
  end

  def add_row(i, j, x)
    (0...@matrix.size).each { |k| @matrix[i][k] += @matrix[j][k]* x }
  end

  def [](i)
    @matrix[i]
  end

  def show(a, b)
    (0...a.size).each do |i|
      (0...a.size).each { |j| print "%.3f " % a[i][j] }
      print " | "
      (0...a.size).each { |j| print "%.3f " % b[i][j] }
      puts
    end
    puts " ------------- "
  end

  def show(n = 3)
    @matrix.each do |row|
      puts row.map { |v| v.round(n).to_s.ljust(2 * n + 1) }.join(" ")
    end
  end

  def swap_row(a, b)
    return if a == b
    (0...size).each do |i|
      k = self[i][a]
      self[i][a] = self[i][b]
      self[i][b] = k
    end
  end

  def inverse
    m = Matrix.new(@matrix.map { |row| row.clone } )
    r = Matrix.identity(@matrix.size)
    show(m, r)
    (0...size).each do |i|
      pivot_row = (i...size).find { |p| m[p][i] != 0}
      # puts i
      # show(m, r)
  		raise "Matrix has no inverse" if pivot_row.nil?
      m.swap_row(i, pivot_row)
      r.swap_row(i, pivot_row)

      m[i][i] == 0

  		r.multiply_row(i, 1.0 / m[i][i])
  		m.multiply_row(i, 1.0 / m[i][i])

  		(i + 1...size).each do |j|
  			r.add_row(j, i, -m[j][i]);
  			m.add_row(j, i, -m[j][i]);
  		end
    end

    (0...size).reverse_each do |i|
    	(0...i).reverse_each do |j|
    		r.add_row(j, i, -m[j][i]);
    		m.add_row(j, i, -m[j][i]);
    	end
    end

    # show(@matrix, r)
    r
  end

  def self.identity(n : Int)
    ident = Array.new(n) { row = Array.new(n, 0_f64) }
    (0...n).each { |i| ident[i][i] = 1_f64 }
    new(ident)
  end
end
