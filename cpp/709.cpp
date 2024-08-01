#include <iostream>
using namespace std;

const int64_t MOD = 1020202009;

int64_t pow(int64_t a,int64_t b, int64_t c) {
  if (b == 0 || a == 1){
    return 1;
  }
  else if (b == 1) {
    return a;
  } else {
    auto h = b / 2;
    auto t = pow(a, h, c);
    return t * t % c * pow(a, b % 2, c) % c;
  }
}

int64_t inv(int64_t a, int64_t p) {
  return pow(a, p - 2, p);
}

const int64_t N = 24700;
int64_t FACTORIALS[N];
int64_t FACTORIALS_i[N];

const int64_t comb(int64_t n, int64_t k) {
  return FACTORIALS[n] * FACTORIALS_i[k] % MOD * FACTORIALS_i[n - k] % MOD;
}

int64_t dp[N];

int main() {
  int n = 10;
  FACTORIALS[0] = 1;
  FACTORIALS_i[0] = 1;
  for (int i = 1; i <= n; i++) {
    FACTORIALS[i] = FACTORIALS[i - 1] * i % MOD;
    FACTORIALS_i[i] = inv(FACTORIALS[i], MOD);
  }

  dp[0] = 1;
  dp[1] = 1;

  for (int i = 2; i <= n; i++) {
    int64_t sum = 0;
    for (int k = 0; k < i; k++) {
      sum = (sum + (FACTORIALS[i - 1] * FACTORIALS_i[i - 1 - k] % MOD * FACTORIALS_i[k] % MOD * dp[k] % MOD * dp[i - 1 - k] % MOD)) % MOD;
    }
    dp[i] = sum / 2;
    cout << i << ": " << dp[i] << endl;
  }
  return 0;
}
