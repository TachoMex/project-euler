module StringUtils
  def slides(str, n)
    (0..(str.size - n)).map{ |i| str[i, n]}
  end
end
