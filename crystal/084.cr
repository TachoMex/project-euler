require "random"
require "./lib/matrix"

GRAPH = {
  "GO" => { "GO" => 1 },
  "A1" => { "A1" => 1 },
  "CC1" => {
    "GO" => 1.0_f64 / 16,
    "JAIL" => 1.0_f64 / 16,
    "CC1" => 1.0_f64/ 14
  },
  "A2" => { "A2" => 1 },
  "T1" => { "T1" => 1 },
  "R1" => { "R1" => 1 },
  "B1" => { "B1" => 1 },
  "CH1" => {
   "GO" => 1.0_f64 / 16,
   "JAIL" => 1.0_f64 / 16,
   "C1" => 1.0_f64 / 16,
   "E3" => 1.0_f64 / 16,
   "H2" => 1.0_f64 / 16,
   "R1" => 1.0_f64 / 16,
   "R2" => 1.00_f64 / 8,
   "U1" => 1.0_f64 / 16,
   "T1" => 1.0_f64 / 16,
   "CH1" => 6.0_f64 / 16
  },
  "B2" => { "B2" => 1 },
  "B3" => { "B3" => 1 },
  "JAIL" => { "JAIL" => 1 },
  "C1" => { "C1" => 1 },
  "U1" => { "U1" => 1 },
  "C2" => { "C2" => 1 },
  "C3" => { "C3" => 1 },
  "R2" => { "R2" => 1 },
  "D1" => { "D1" => 1 },
  "CC2" => {
    "GO" => 1.0_f64 / 16,
    "JAIL" => 1.0_f64 / 16,
    "CC2" => 7.0_f64 / 8
  },
  "D2" => { "D2" => 1 },
  "D3" => { "D3" => 1 },
  "FP" => { "FP" => 1 },
  "E1" => { "E1" => 1 },
  "CH2" => {
    "GO" => 1.0_f64 / 16,
    "JAIL" => 1.0_f64 / 16,
    "C1" => 1.0_f64 / 16,
    "E3" => 1.0_f64 / 16,
    "H2" => 1.0_f64 / 16,
    "R1" => 1.0_f64 / 16,
    "R3" => 1.00_f64 / 8,
    "U2" => 1.0_f64 / 16,
    "D3" => 1.0_f64 / 16,
    "CH2" => 6.0_f64 / 16
  },
  "E2" => { "E2" => 1 },
  "E3" => { "E3" => 1 },
  "R3" => { "R3" => 1 },
  "F1" => { "F1" => 1 },
  "F2" => { "F2" => 1 },
  "U2" => { "U2" => 1 },
  "F3" => { "F3" => 1 },
  "G2J" => {
    "JAIL" => 1
  },
  "G1" => { "G1" => 1 },
  "G2" => { "G2" => 1 },
  "CC3" => {
    "GO" => 1.0_f64 / 16,
    "JAIL" => 1.0_f64 / 16,
    "CC3" => 7.0_f64 / 8
  },
  "G3" => { "G3" => 1 },
  "R4" => { "R4" => 1 },
  "CH3" => {
    "GO" => 1.0_f64 / 16,
    "JAIL" => 1.0_f64 / 16,
    "C1" => 1.0_f64 / 16,
    "E3" => 1.0_f64 / 16,
    "H2" => 1.0_f64 / 16,
    "R1" => 1.0_f64 / 16,
    "R1" => 1.00_f64 / 8,
    "U1" => 1.0_f64 / 16,
    "CC3" => 1.0_f64 / 16,
    "CH3" => 6.0_f64 / 16
  },
  "H1" => { "H1" => 1 },
  "T2" => { "T2" => 1 },
  "H2" => { "H2" => 1 }
}

N = 4
ITERATIONS = 10 ** 6

visits = Array.new(40, 0)

position = "GO"
pairs = 0

1.upto(ITERATIONS) do
  dice_a = (1..N).to_a.sample
  dice_b = (1..N).to_a.sample
  if dice_a == dice_b
    pairs += 1
  else
    pairs = 0
  end

  if pairs == 3
    next_ = GRAPH["JAIL"]
  else
    node_k = (BOARD.index(position) || raise "Invalid position '#{position}'")
    idx = node_k + dice_a + dice_b
    next_ = GRAPH[BOARD[idx % BOARD.size]]
  end
  r = Random.rand
  sum = 0
  i = 0
  while sum <= r && i < next_.size
    sum += next_[next_.keys[i]]
    i += 1
  end
  visits[BOARD.index(position) || raise "Invalid position"] += 1
  position = next_.keys[i - 1]
end


results = Hash.zip(BOARD, visits).map { |k, v| {k, v} }.sort { |a, b| a[1] <=> b[1] }

puts results.reverse[0, 3].map { |k| BOARD.index(k[0]) }.reverse.join
