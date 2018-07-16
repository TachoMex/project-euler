require "./lib/number_theory"

n = 600_851_475_143

include NumberTheory

factors = factors(n)

puts(factors.last)
