#include <iostream>
#include <vector>
#include <map>
#include <functional>
#include <cstring>

using namespace std;

#define MAX(X, Y) (X) > (Y) ? (X) : (Y)

const int64_t F = 10000;
const int64_t N = F * F;

typedef vector<int64_t> List;

map<int64_t, map<int64_t, int64_t>> memory;
List primes;
int sieve[N+1];
int sieve_b[N+1];
int index_of_primes[N+1];
vector<List> factorials;

List factor_vector_add(const List &a, const List &b) {
  List c(MAX(a.size(), b.size()));
  for (size_t i = 0; i < a.size(); i++) {
    c[i] += a[i];
  }

  for (size_t i = 0; i < b.size(); i++) {
    c[i] += b[i];
  }

  return c;
}

List factorial_prime_factors(int64_t n) {
  List ans;
  int64_t i = 0;
  while (i < primes.size() && primes[i] <= n) {
    int64_t count = 0;
    int64_t t = n;
    while (t > 0) {
      count += t / primes[i];
      t /= primes[i];
    }
    ans.push_back(count);
    i++;
  }
  return ans;
}

List prime_factors(int64_t n) {
  List result;
  int64_t i = 0;
  while (n > 1) {
    // cout << "Factoring " << n << ">>" << primes[i] << endl;
    int64_t count = 0;
    while (n % primes[i] == 0) {
      count++;
      n /= primes[i];
    }
    i++;
    result.push_back(count);
  }
  return result;
}

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

int64_t binsearch(int64_t left, int64_t right, function<bool (int64_t)> func) {
  int64_t last = -1;
  while (left <= right) {
    int64_t med = (left + right) / 2;
    auto f_med = func(med);
    if (f_med) {
      last = med;
      right = med - 1;
    } else {
      left = med + 1;
    }
  }
  return last;
}

int64_t f(int64_t n, int top_prime) {
  if (!sieve[n]) return n;
  auto needed = prime_factors2(n);
  int64_t ans = 0;
  // for(int i = 0; i < needed.size(); i++) {
  //   auto b = needed[i];
  //   if (b == 0) continue;
  //   if (primes[i] > top_prime) {
  //     ans = MAX(ans, primes[i] * b);
  //   } else {
  //     ans = MAX(ans, dp[i][b]);
  //   }
  // }
  for(auto& [p, b] : needed) {
    // cout << p << " >> " << b << endl;
    auto i = index_of_primes[p];
    if (memory[i].count(b)) {
      ans = MAX(memory[i][b], ans);
      continue;
    } else  {
      int64_t last = -1, left = 0, right = factorials.size() - 1;
      while (left <= right) {
        int64_t med = (left + right) / 2;
        auto f_med = i >= factorials[med].size() ? -1 : factorials[med][i];
        if (f_med >= b) {
          last = med;
          right = med - 1;
        } else {
          left = med + 1;
        }
      }
      if (last == -1)
        last = p * b;
      // cout << p << " >> " << b << " kkk " << last << endl;
      memory[i][b] = last;
      ans = MAX(ans, last);
    }
  }
  return ans;
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

  int64_t top_prime_index = binsearch(0, primes.size() - 1, [&](int64_t med){
    // cout << med << " :> " << primes[med] << endl;
    return F < primes[med];
  });

  int64_t top_prime = primes[top_prime_index - 1] * 2;

  cout << "Sieve ready " << top_prime <<  " / " << F << endl;

  for (int64_t i = 0; i <= top_prime; i++) {
    // cout << "Factorial ready " << i << endl;
    factorials.push_back(factorial_prime_factors(i));
    // for (auto v : factorials.back()) {
    //   cout << v << " ";
    // }
    // cout << endl;
  }


  cout << primes[top_prime_index] << " == " << primes[factorials[top_prime].size() - 2] << endl;
  int max_exp = factorials.back().front();

  // int** dp = new int*[top_prime + 1];
  // for(int i = 0; i < top_prime + 1; ++i) {
  //     dp[i] = new int[max_exp + 1];
  //     memset(dp[i], 0, sizeof(dp[i]));
  // }

  // cout << "MAX:" << max_exp << endl;

  // for (int j = 0; j < top_prime_index; j++) {
  //   cout << "DP: " << j << "/" << top_prime_index - 1 << endl;
  //   for (int k = 0; k <= max_exp; k++) {
  //     int i = 0;
  //     while(j >= factorials[i].size() || factorials[i][j] < k) {
  //       // cout << i << " " << j << " " << k << " === "
  //       //      << primes[j] << " " << factorials[i].size()
  //       //      << " " << factorials.size() << endl;
  //       i++;
  //       if (i >= factorials.size()) break;
  //     }
  //     if (i < factorials.size()) dp[j][k] = i;
  //   }
  // }
  cout << "Factorials ready" << endl;

  int64_t ans = 0;
  for (int64_t i = 2; i <= N; i++) {
    if (i % 100000 == 0) cout << i << "/" << N << " => " << ans << endl;
    auto x = f(i, primes[top_prime_index - 1]);
    // cout << i << " :: " << x << endl;
    // cout << i << " " << sieve[i] << " " << sieve_b[i] << endl;
    ans += x;
  }
  cout << ans << endl;

  // cout << f(96, primes[top_prime_index - 1]) << endl;
  return 0;
}

