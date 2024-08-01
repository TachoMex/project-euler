#include <iostream>
#include <vector>
#include <map>
#include <functional>
#include <cstring>

using namespace std;

const int64_t F = 10;
const int64_t N = 100; // F * F * F;

typedef vector<int64_t> List;

map<int64_t, map<int64_t, int64_t>> memory;
List primes;
int sieve[N+1];
int sieve_b[N+1];
int index_of_primes[N+1];
vector<List> factorials;

map<int, int> prime_factors2(int64_t n) {
  map<int, int> ans;

  while (true) {
    if (sieve[n]) {
      ans[sieve[n]]++;
      n /= sieve[n];
    }
    else {
      ans[n]++;
      return ans;
    }
  }
}

int main() {
  cin.tie(0);
  cin.sync_with_stdio(0);

  sieve[0] = 1;
  sieve[1] = 1;

  for (int64_t i = 0; i <= N; i++) {
    if (sieve[i]) continue;

    for (int j = i + i; j <= N; j += i) {
      sieve[j] = i;
      sieve_b[j]++;
    }
  }

  for (int64_t i = 0; i <= N; i++) {
    if (!sieve[i]) {
      index_of_primes[i] = primes.size();
      primes.push_back(i);
    }
  }

  int64_t sum = N;

  for (int i = 2; i <= F; i++) {
    auto factors = prime_factors2(i);
    bool cube = true;
    cout << i << ": ";
    for (auto& [p, b] : factors) {
      cout << p << "**" << b << " ";
      cube = cube && b >= 2;
    }
    if (cube) {
      int k = N;
      while (k) {
        sum += k /= i;
      }
      cout << "cube";
    }
    cout << endl;
  }
  cout << sum << endl;
  // cout << f(96, primes[top_prime_index - 1]) << endl;
  return 0;
}

