#include <iostream>
using std::cout;
using std::endl;
using std::max;

const int64_t N = 600851475143;

int main(void) {
  int64_t i = 2;
  int64_t n = N;
  int64_t biggest_prime = -1;
  while (i * i <= n) {
    while (n % i == 0) {
      n /= i;
      biggest_prime = max(biggest_prime, i);
    }
    ++i;
  }
  biggest_prime = max(biggest_prime, n);
  cout << biggest_prime << endl;
  return 0;
}
