#ifndef CPP_LIB_NUMBER_THEORY_HPP_
#define CPP_LIB_NUMBER_THEORY_HPP_

#include <cstring>

namespace number_theory {
  void calc_sieve(bool* sieve, int* primes, int n) {
    memset(sieve, true, sizeof(bool) * n);
    memset(primes, 0, sizeof(int) * n);
    sieve[0] = false;
    sieve[1] = false;

    for (int64_t i = 2; i * i <= n; ++i) {
      for (int64_t j = i * i; j <= n; j += i) {
        sieve[j] = false;
      }
    }
    int k = 0;
    for (int64_t i = 2; i <= n; ++i) {
      if (sieve[i]) {
        primes[k++] = i;
      }
    }
  }
};  // namespace number_theory

#endif  // CPP_LIB_NUMBER_THEORY_HPP_
