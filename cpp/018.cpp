#include <iostream>
using namespace std;

int m[20][20];

void sum(int i, int j, int a, int b){
  if(a <= 0 || b <= 0){
    return;
  }
  m[a][b] += m[i][j];
}

int main(){
  for(int i = 0; i < 15; i++){
    for(int j = 0; j <= i; j++){
      cin >> m[i][j];
    }
  }

  for(int i = 14; i >= 0; i--){
    for(int j = i; j >= 0; j--){
      m[i][j] += max(m[i+1][j], m[i+1][j+1]);
    }
  }


  for(int i = 0; i < 15; i++){
    for(int j = 0; j < 15; j++){
      cout << m[i][j] << ' ';
    }
    cout << endl;
  }

  return 0;
}
