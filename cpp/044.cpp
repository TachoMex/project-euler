#include <iostream>
using namespace std;

#define P(n) ((n) * (3 * (n) - 1) / 2)
const int N = 3000;

bool test_pentagon(long long int n){
  long long int i = 1, j = n;
  while(i <= j){
    long long int k = (i + j) / 2;
    long long int fk = P(k);
    if(fk == n){
      return true;
    }else if(fk < n){
      i = k + 1;
    }else{
      j = k - 1;
    }
  }
  return false;
}

int main(){
  for(int i = 1; i < N; i++){
    int p_i = P(i);
    for(int j = i; j > 0; j--){
      int p_j = P(j),
          x = p_i + p_j,
          y = p_i - p_j;
      if(test_pentagon(x) && test_pentagon(y)){
        cout << y << endl;
        exit(0);
      }
    }
  }
  return 0;
}
