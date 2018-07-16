#include <iostream>
#include <algorithm>
using std::cout;
using std::endl;
using std::__gcd;

const int64_t N = 100;

int main(void) {
  int64_t sums = 0;
  int64_t squares = 0;
  for (int64_t i = 1; i <= N; ++i) {
    sums += i;
    squares += i * i;
  }
  cout << sums * sums - squares << endl;
  return 0;
}
