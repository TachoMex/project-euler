#include <iostream>
#include <algorithm>
using std::cout;
using std::endl;
using std::__gcd;

const int64_t N = 20;

int main(void) {
  int64_t ans = 1;
  for (int64_t i = 1; i <= N; ++i) {
    ans = ans / __gcd(ans, i) * i;
  }
  cout << ans << endl;
  return 0;
}
