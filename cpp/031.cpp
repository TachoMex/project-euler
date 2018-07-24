#include <iostream>

using namespace std;

const int N = 5000;
int dp[N];


int main(){
  int n;
  int k;
  cin >> k >> n;
  dp[0] = 1;
  for(int i = 1; i <= n; i++){
    int c;
    cin >> c;
    for(int j = 0; j + c <= k; j++){
      dp[j + c] += dp[j];
      cout << dp[j] << ' ';
    }
    cout << endl;
  }
  cout << dp[k] << endl;
  return 0;
}
