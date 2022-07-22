TEST = [
  [7,53,183,439,863],
  [497,383,563,79,973],
  [287,63,343,169,583],
  [627,343,773,959,943],
  [767,473,103,699,303],
]

CASE = [
  [7, 53, 183, 439, 863, 497, 383, 563, 79, 973, 287, 63, 343, 169, 583],
  [627, 343, 773, 959, 943, 767, 473, 103, 699, 303, 957, 703, 583, 639, 913],
  [447, 283, 463, 29, 23, 487, 463, 993, 119, 883, 327, 493, 423, 159, 743],
  [217, 623,  3, 399, 853, 407, 103, 983, 89, 463, 290, 516, 212, 462, 350],
  [960, 376, 682, 962, 300, 780, 486, 502, 912, 800, 250, 346, 172, 812, 350],
  [870, 456, 192, 162, 593, 473, 915, 45, 989, 873, 823, 965, 425, 329, 803],
  [973, 965, 905, 919, 133, 673, 665, 235, 509, 613, 673, 815, 165, 992, 326],
  [322, 148, 972, 962, 286, 255, 941, 541, 265, 323, 925, 281, 601, 95, 973],
  [445, 721, 11, 525, 473, 65, 511, 164, 138, 672, 18, 428, 154, 448, 848],
  [414, 456, 310, 312, 798, 104, 566, 520, 302, 248, 694, 976, 430, 392, 198],
  [184, 829, 373, 181, 631, 101, 969, 613, 840, 740, 778, 458, 284, 760, 390],
  [821, 461, 843, 513, 17, 901, 711, 993, 293, 157, 274, 94, 192, 156, 574],
  [34, 124,  4, 878, 450, 476, 712, 914, 838, 669, 875, 299, 823, 329, 699],
  [815, 559, 813, 459, 522, 788, 168, 586, 966, 232, 308, 833, 251, 631, 107],
  [813, 883, 451, 509, 615, 77, 281, 613, 459, 205, 380, 274, 302, 35, 805],
]

SOLVE = CASE
solve = SOLVE.map { |r| r.map { |c| -c } }

n = solve.size

def min_zero_row(zero_mat, mark_zero)
  min_row = [100000000, -1]
  n = zero_mat.size

  (0...n).each do |r|
    zeros = zero_mat[r].count { |x| x }
    min_row = [zeros, r] if zeros > 0 && zeros < min_row[0]
  end

  zero_index = zero_mat[min_row[1]].index { |row| row }.as(Int32)
  mark_zero << [min_row[1], zero_index]
  (0...n).each { |i| zero_mat[min_row[1]][i] = zero_mat[i][zero_index] = false }
end

def mark_matrix(matrix)
  n = matrix.size
  cur_matrix = matrix
  zero_bool_matrix = cur_matrix.map { |r| r.map { |x| x.zero? } }
  zero_bool_mat_copy = zero_bool_matrix.clone
  marked_zero = [] of Array(Int32)
  while zero_bool_mat_copy.any? { |r| r.includes?(true) }
    min_zero_row(zero_bool_mat_copy, marked_zero)
  end
  marked_zero_row = [] of Int32
  marked_zero_col = [] of Int32
  (0...marked_zero.size).each do |i|
    marked_zero_row << marked_zero[i][0]
    marked_zero_col << marked_zero[i][0]
  end
  non_marked_row = (0...n).reject { |v| marked_zero_row.includes?(v) }
  marked_cols = [] of Int32
  check_switch = true
  while check_switch
    check_switch = false
    (0...non_marked_row.size).each do |i|
      row_array = zero_bool_matrix[non_marked_row[i]]
      (0...row_array.size).each do |j|
        if row_array[j] == true && !marked_cols.includes?(j)
          marked_cols << j
          check_switch = true
        end
      end
    end
    marked_zero.each do |(row_num, col_num)|
      if !non_marked_row.includes?(row_num) && marked_cols.includes?(col_num)
        non_marked_row << row_num
        check_switch = true
      end
    end
  end
  marked_rows = (0...n).reject { |v| non_marked_row.includes?(v) }
  { marked_zero, marked_rows, marked_cols }
end

def adjust_matrix(mat, cover_rows : Array(Int32), cover_cols : Array(Int32))
  cur_matrix = mat
  n = mat.size
  non_zero_element = [] of Int32
  (0...n).each do |row|
    next if cover_rows.includes?(row)

    (0...cur_matrix[row].size).each do |i|
      non_zero_element << cur_matrix[row][i] unless cover_cols.includes?(i)
    end
  end
  min_num = non_zero_element.min
  (0...n).each do |row|
    next if cover_rows.includes?(row)

    (0...cur_matrix[row].size).each do |i|
      cur_matrix[row][i] = cur_matrix[row][i] - min_num unless cover_cols.includes?(i)
    end
  end
  (0...cover_rows.size).each do |row|
    (0...cover_cols.size).each do |col|
      cur_matrix[cover_rows[row]][cover_cols[col]] += min_num # FIXME
    end
  end
  cur_matrix
end

def hungarian_algorithm(matrix)
  n = matrix.size
  cur_matrix = matrix.clone
  (0...n).each do |row_num|
    min_val = (0...cur_matrix.size)
      .map { |i| cur_matrix[row_num][i] }
      .min
    (0...n).each do |i|
      cur_matrix[row_num][i] -= min_val
    end
  end
  (0...n).each do |col_num|
    min_val = (0...n).map { |i| cur_matrix[i][col_num] }.min
    (0...n).each do |i|
      cur_matrix[i][col_num] -= min_val
    end
  end
  zero_count = 0
  ans_matches = [] of Array(Int32)
  while zero_count < n
    ans_matches, marked_rows, marked_cols = mark_matrix(cur_matrix)
    zero_count = marked_rows.size + marked_cols.size
    cur_matrix = adjust_matrix(cur_matrix, marked_rows, marked_cols) if zero_count < n
  end
  ans_matches
end

def ans_calculation(mat, pos)
  total = 0
  n = mat.size
  ans_matrix = (0...n).map { (0...mat[0].size).map { 0 } }
  (0...pos.size).each do |i|
    total += mat[pos[i][0]][pos[i][1]]
    ans_matrix[pos[i][0]][pos[i][1]] = mat[pos[i][0]][pos[i][1]]
  end
  [total, ans_matrix]
end


inverse_values = SOLVE
max = inverse_values.map { |r| r.max }.max
matrix = inverse_values.map { |r| r.map { |c| max - c } }

ans_matches = hungarian_algorithm(matrix.clone)
ans, ans_matrix = ans_calculation(inverse_values, ans_matches)
puts ans
puts ans_matrix
