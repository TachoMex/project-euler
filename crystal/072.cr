require "big"
require "./lib/number_theory"

include NumberTheory

puts (1_i64..10_i64**6).map { |n| BigInt.new(phi_e(n)) }.sum -1
