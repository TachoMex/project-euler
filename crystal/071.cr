n = 3.to_f64 / 7
r = { 2, 7 }
r_f = 2.to_f64 / 7

(4..10**6).each do |t|
  i = 4
  j = 10**6
  while i <= j
    k = (i + j) / 2
    f_k = k.to_f64 / t
    if f_k < n
      if f_k > r_f
        r_f = f_k
        r = { k, t }
      end
      i = k + 1
    else
      j = k - 1
    end
  end
end
puts r[0]
