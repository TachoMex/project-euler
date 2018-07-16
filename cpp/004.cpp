#include <iostream>
#include <string>
#include <algorithm>
using std::cout;
using std::endl;
using std::max;
using std::reverse;
using std::stoi;
using std::to_string;

const int N = 999;

int main(void) {
  int ans = 0;
  for (int i = 100; i <= N; ++i) {
    for (int j = 100; j <= N; ++j) {
      int c = i * j;
      auto s = to_string(c);
      reverse(s.begin(), s.end());
      if (c == stoi(s)) {
        ans = max(ans, c);
      }
    }
  }
  cout << ans << endl;
  return 0;
}
