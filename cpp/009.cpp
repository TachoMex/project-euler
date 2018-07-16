#include <iostream>
using std::cout;
using std::endl;

const int N = 1000;

int main(void) {
  for (int i = 1; i < N; ++i) {
    for (int j = i; j < N; ++j) {
      int k = N - i - j;
      if (i * i + j * j == k * k) {
        cout << i * j * k << endl;
        return 0;
      }
    }
  }
  return 0;
}
