#include <iostream>
#include <queue>
#include <map>

using namespace std;


const int64_t F = 1000;
const int64_t N = F * F;
const int64_t MOD = 1000000007;

int main() {
  queue<pair<int64_t, int64_t>> q;

  q.push(pair(1, 2));

  int64_t ans = 1;

  while (!q.empty()) {
    auto next = q.front();
    q.pop();
    cout << q.size() << endl;
    auto a = next.first;
    auto b = next.second;
    // cout << a << ", " << b << endl;
    ans *= a;
    ans %= MOD;
    int64_t c = a + b;
    if (c <= N) {
      auto t1 = c < b ? pair<int64_t, int64_t>(c, b) : pair<int64_t, int64_t>(b, c);
      q.push(t1);
      t1 = a < c ? pair<int64_t, int64_t>(a, c) : pair<int64_t, int64_t>(c, a);
      q.push(t1);
    }
  }

  cout << ans << endl;
  return 0;
}