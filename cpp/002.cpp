#include <iostream>
using std::cout;
using std::endl;

const int N = 4000000;

int main(void) {
  int a = 1;
  int b = 2;
  int sum = b;
  while (b <= N) {
    int c = a + b;
    a = b;
    b = c;
    if (b % 2 == 0) {
      sum += b;
    }
  }
  cout << sum << endl;
  return 0;
}
