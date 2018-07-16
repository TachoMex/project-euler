#include <iostream>
using namespace std;

const int N = 30000;

int divs_sum[N];
bool dp[N];

int main(){
  for(int i = 1; i < N; i++){
    for(int j = i + i; j < N; j += i){
      divs_sum[j] += i;
    }
  }

  for(int i=24; i < N; i++){
    for(int j = 12; j < i; j++){
      if(divs_sum[j] > j && divs_sum[i - j] > i - j){
        dp[i] = true;
        break;
      }
    }
  }
  long long int sum = 0;
  for(int i=1; i < N; i++){
    // if(divs_sum[i] > i){
    if(!dp[i]){
      sum += i;
      cout << i << endl;
    }
  }
  cout << sum  << endl;
  return 0;
}
