def encrypt_chunk(text, key)
  (0...text.size).map { |i| (text[i].ord ^ key[i].ord).chr }.join
end

def encrypt(text, key)
  msg = [] of String
  text.chars.each_slice(key.size) { |slice| msg << encrypt_chunk(slice, key) }
  msg.flatten.join
end

text = File.read("../059.in").split(',').map { |c| c.to_i.chr }.join

('a'..'z').each do |a|
  ('a'..'z').each do |b|
    ('a'..'z').each do |c|
      pass = [a, b, c].join
      # pass = "poc"
      message = encrypt(text, pass)
      distribution = message.chars
                            .reduce({} of Char => Int32) do |h, e|
                              h[e] ||= 0
                              h[e] += 1
                              h
                            end
      letters = distribution.to_a.sort { |a, b| b[1] <=> a[1] }.map { |h| h[0] }.join.downcase.chars.uniq.join
      count = letters.count { |c| ('a'..'z').covers? c }
      if message.downcase.includes?("of") && message.downcase.includes?("and") && message.downcase.includes?("john")
        puts message.chars.map { |c| c.ord }.sum
      end
    end
  end
end
