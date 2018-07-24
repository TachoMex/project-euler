#include <iostream>

#include "lib/number_theory.hpp"

using std::cout;
using std::endl;
using number_theory::calc_sieve;

const int64_t N = 2000000;
int primes[N + 1];
bool sieve[N + 1];

int main(void) {
  calc_sieve(sieve, primes, N);
  int64_t sum = 0;
  for (int i = 0; primes[i]; ++i) {
    sum += primes[i];
  }
  cout << sum << endl;
  return 0;
}
