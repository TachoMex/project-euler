#include <iostream>

using namespace std;

const int N = 10000000;

int collats[N];
bool calculated[N];

int collatsf(long long int n){
  if(n == 1){
    return 1;
  }
  if(n < N and calculated[n]){
    return collats[n];
  }

  long long int next = (n % 2 == 0 ? n / 2 : 3 * n + 1);
  int c = collatsf(next) + 1;
  if(n < N){
    calculated[n] = true;
    collats[n] = c;
  }
  return c;
}

int main(){
  int res = 0;
  for(int i=1; i<=1000000;i++){
    int c = collatsf(i);
    res = (collats[res] > c ? res : i);
  }
  cout << res << endl;
  return 0;
}
