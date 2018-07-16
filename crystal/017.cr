UNITS = %w[zero one two three four five six seven eight nine]
DECENS = %w[none ten twenty thirty forty fifty sixty seventy eighty ninety]
SPECIALS = {
  11 => "eleven",
  12 => "twelve",
  13 => "thirteen",
  14 => "fourteen",
  15 => "fifteen",
  16 => "sixteen",
  17 => "seventeen",
  18 => "eighteen",
  19 => "nineteen",
}
def to_word(n)
  if SPECIALS[n]?
    SPECIALS[n]
  elsif n < 10
    UNITS[n]
  elsif n < 100
    DECENS[n / 10] + ((UNITS[n % 10] unless (n % 10).zero?) || "")
  else
    n % 100 == 0 ? UNITS[n / 100] + "hundred" : UNITS[n / 100] + "hundredand" + to_word(n % 100)
  end
end

puts (1..999).map { |i| to_word(i) }
             .map { |w| w.size }
             .sum  + "onethousand".size
