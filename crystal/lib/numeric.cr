def double_integral(x1, y1, x2, y2, dx, dy)
  nx = ((x2 - x1) / dx ).to_i + 1
  ny = ((y2 - y1) / dy).to_i + 1

  answer = 0f64

  (0...nx).each do |i|
    puts "#{i} / #{nx}"
    ax = 0.0f64
    (0...ny).each do |j|
      f = yield(x1 + dx * i, y1 + dy * j)
      if j == 0 || j == ny - 1
        ax += f
      elsif j % 2 == 0
        ax += f * 2
      else
        ax += f * 4
      end
    end
    ax *= (dy / 3.0)
    if i == 0 || i == nx - 1
      answer += ax
    elsif i % 2 == 0
      answer += 2 * ax
    else
      answer += 4 * ax
    end
  end

  answer * (dx / 3)
end