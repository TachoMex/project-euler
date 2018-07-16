#include <iostream>

#include "lib/number_theory.hpp"

using std::cout;
using std::endl;
using number_theory::calc_sieve;

const int64_t N = 1000000;

int main(void) {
  int primes[N];
  bool sieve[N + 1];
  calc_sieve(sieve, primes, N);
  cout << primes[10000] << endl;
  return 0;
}
