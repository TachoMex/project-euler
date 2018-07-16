#include <iostream>
#include <map>
using namespace std;

map<int, bool> primes;
int prime(int n){
  if(n % 2 == 0 || n <= 1){
    return false;
  }
  if(primes.count(n)){
    return primes[n];
  }
  for(long long int i = 3; i * i <= n; i += 2){
    if(n % i == 0){
      return primes[n] = false;
    }
  }

  return primes[n] = true;
}

int main(){
  int g, g_s = -1;
  for(int a = -999; a <= 999; a++){
    for(int b = -1000; b <= 1000; b++){
      int n = -1, p;
      do{
        n += 1;
        p = n * n + a * n + b;
        // cout << p << endl;
      }while(prime(p));
      if(n > g_s){
        g_s = n;
        g = a * b;
      }
    }
  }
  cout << g << " -- " << g_s << endl;
  return 0;
}
