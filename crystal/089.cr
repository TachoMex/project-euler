def parse(str)
  val = 0
  i = 0
  while i < str.size
    case str[i, 2]
    when "CM"
      i += 2
      val += 900
    when "CD"
      i += 2
      val += 400
    when "XL"
      i += 2
      val += 40
    when "XC"
      i += 2
      val += 90
    when "IX"
      i += 2
      val += 9
    when "IV"
      i += 2
      val += 4
    else
      case str[i]
      when 'M'
        i += 1
        val += 1000
      when 'D'
        i += 1
        val += 500
      when 'C'
        i += 1
        val += 100
      when 'L'
        i += 1
        val += 50
      when 'X'
        i += 1
        val += 10
      when 'V'
        i += 1
        val += 5
      when 'I'
        i += 1
        val += 1
      else
        puts "Failing string \"#{str}\""
        exit(0)
      end
    end
  end
  return val
end

def roman_numer(n)
  str = ""

  str += "M" * (n / 1000)
  n %= 1000

  str += "CM" if n >= 900
  n %= 900

  str += "D" if n >= 500
  n %= 500

  str += "CD" if n >= 400
  n %= 400

  str += "C" * (n / 100)
  n %= 100

  str += "XC" if n >= 90
  n %= 90

  str += "L" if n >= 50
  n %= 50

  str += "XL" if n >= 40
  n %= 40

  str += "X" * (n / 10)
  n %= 10

  str += "IX" if n >= 9
  n %= 9

  str += "V" if n >= 5
  n %= 5

  str += "IV" if n >= 4
  n %= 4

  str += "I" * n
  str
end

numbers = File.read_lines("../089.in")
              .map do |l|
                value = parse(l)
                reduced = roman_numer(value)
                l.size - roman_numer(parse(l)).size
               end
              .sum
puts numbers
