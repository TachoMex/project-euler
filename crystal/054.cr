class PokerHand
  CARD_SCORES = {
    '2' => 0,
    '3' => 1,
    '4' => 2,
    '5' => 3,
    '6' => 4,
    '7' => 5,
    '8' => 6,
    '9' => 7,
    'T' => 8,
    'J' => 9,
    'Q' => 10,
    'K' => 11,
    'A' => 12
  }

  CARD_SCORES_REVERSE = Hash.zip(CARD_SCORES.values, CARD_SCORES.keys)

  HAND_SCORES = {
    "HIGH_CARD" => 0,
    "ONE_PAIR" => 1,
    "TWO_PAIR" => 2,
    "THREE" => 3,
    "STRAIGHT" => 4,
    "FLUSH" => 5,
    "FULL_HOUSE" => 6,
    "POKER" => 7,
    "STRAIGHT_FLUSH" => 8,
    "ROYAL_FLUSH" => 9
  }
  ROYAL_FLUSH = ['T', 'J', 'Q', 'K', 'A']

  @numbers : Array(Char)
  @suits : Array(Char)

  getter :cards

  def initialize(cards : Array(String))
    @cards = cards
    @numbers = cards.map { |c| c[0] }
    @suits = cards.map { |c| c[1] }
  end

  def single_suit?
    @suits.group_by { |a| a }.size == 1
  end

  def sorted_numbers
    @numbers.sort { |a, b| CARD_SCORES[a] <=> CARD_SCORES[b] }
  end

  def grouped_numbers
    @numbers.group_by { |a| a }.to_a.sort { |a, b| b[1].size <=> a[1].size }
  end

  def royal_flush?
    sorted_numbers == ROYAL_FLUSH && single_suit?
  end

  def straight_flush?
    flush? && straight?
  end

  def poker?
    grouped_numbers[0][1].size == 4
  end

  def three_of_a_kind?
    grouped_numbers[0][1].size == 3 && grouped_numbers[1][1].size == 1
  end

  def two_pairs?
    grouped_numbers[0][1].size == 2 && grouped_numbers[1][1].size == 2
  end

  def pair?
    grouped_numbers[0][1].size == 2 && grouped_numbers[1][1].size == 1
  end

  def full_house?
    grouped_numbers[0][1].size == 3 && grouped_numbers[1][1].size == 2
  end

  def flush?
    single_suit?
  end

  def straight?
    numbers = sorted_numbers
    lower = CARD_SCORES.keys.index(numbers.first) || 0
    upper = CARD_SCORES.keys.index(numbers.last) || 0
    (lower..upper).map { |c| CARD_SCORES_REVERSE[c] } == numbers
  end

  def hand_type
    if royal_flush?
      "ROYAL_FLUSH"
    elsif straight_flush?
      "STRAIGHT_FLUSH"
    elsif poker?
      "POKER"
    elsif full_house?
      "FULL_HOUSE"
    elsif flush?
      "FLUSH"
    elsif straight?
      "STRAIGHT"
    elsif three_of_a_kind?
      "THREE"
    elsif two_pairs?
      "TWO_PAIR"
    elsif pair?
      "ONE_PAIR"
    else
      "HIGH_CARD"
    end
  end

  def hand_score
    HAND_SCORES[hand_type] * 13 ** 7
  end

  def score
    hand_score + cards_score
  end

  def cards_score
    @numbers.sort do |a,b|
                    a_c = @numbers.count { |x| a == x }
                    b_c = @numbers.count { |x| b == x }
                    if a_c == b_c
                      CARD_SCORES[a] <=> CARD_SCORES[b]
                    else
                      a_c <=> b_c
                    end
                  end
            .map_with_index { |c, i| CARD_SCORES[c] * 13**i }
            .sum
  end
end

hands = File.read_lines("../054.in")
            .map { |line| line.split(' ') }
            .map { |row| { a: PokerHand.new(row[0,5]), b: PokerHand.new(row[5, 5]) } }

puts hands.count { |hand| hand[:a].score > hand[:b].score }
