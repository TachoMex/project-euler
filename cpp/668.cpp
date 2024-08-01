#include <iostream>
#include <vector>
#include <cmath>
using namespace std;

//                 1234567890
const int64_t F = 100000;
const int64_t N = F * F;

int sieve[F + 1];

vector<int64_t> primes;

// int64_t calc_max_factor(int64_t n, int64_t idx = 0) {
//   if (n <= F) {
//     return sieve[n];
//   } else {
//     for (; idx < primes.size(); idx++) {
//       if (n % primes[idx] == 0) {
//         return max(primes[idx], calc_max_factor(n / primes[idx], idx));
//       }
//     }
//     return n;
//   }
// }

int64_t rec(int64_t k, int64_t maxp, int idx, bool taken) {
  if (k > N || idx >= primes.size()) {
    return 0;
  }
  int64_t ans = 0;
  if (!taken && sqrt(k) > maxp) {
    // cout << k << endl;
    ans += 1;
  }
  return ans + rec(k * primes[idx], max(maxp, primes[idx]), idx, false) + rec(k, maxp, idx+1, true);
}

int main() {
  sieve[1] = 1;
  int64_t sum = 0;
  for(int64_t i = 2; i <= F; i++) {
    if (sieve[i] == 0) {
      primes.push_back(i);
      for (int64_t j = i; j <= F; j += i) {
        sieve[j] = i;
      }
    }
  }
  cout << rec(1, 1, 0, false) + 1<< endl;
  return 0;
}
