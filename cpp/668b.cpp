#include <iostream>
#include <fstream>
#include <cmath>
using namespace std;
//                 1234567890
const int64_t N = 10000000000;

void put_value(int64_t idx, int64_t val, fstream& file) {
  file.seekp(idx * sizeof(int64_t), file.beg);
  file.write((const char*)&val, sizeof(int64_t));
}

int64_t get_value(int64_t idx, fstream& file) {
  int64_t ans;
  file.seekg(idx * sizeof(int64_t), file.beg);
  file.read((char*)&ans, sizeof(int64_t));
  return ans;
}

int main() {
  fstream sieve;
  sieve.open("./668.data", fstream::in | fstream::out | fstream::binary | fstream::trunc);

  for (int i = 0; i <= N; i++) {
    put_value(i, 0, sieve);
  }

  int64_t ans = 1;

  for (int64_t i = 2; i <= N; i++) {
    int64_t p = get_value(i, sieve);
    if (p == 0) {
      for (int64_t j = i; j <= N; j += i) {
        put_value(j, i, sieve);
      }
      sieve.flush();
    } else {
      if (p < sqrt(i)) {
        ans += 1;
      }
    }
  }

  sieve.close();

  cout << ans << endl;
  return 0;
}
