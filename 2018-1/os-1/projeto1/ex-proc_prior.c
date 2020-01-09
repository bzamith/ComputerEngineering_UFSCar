/* 
 * Uso da nova chamada de sistema
 */ 
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[]) {
int argv1, argv2;

argv1 = atoi(argv[1]);
argv2 = atoi(argv[2]);

  if(argc!=3){
	printf("Os argumentos passados foram errados.\n");
	return -1;
  }
  int r = syscall(358, argv1, argv2); 
  if(r==2){
	  printf("Prioridade nao permitida (-20 a 19)\n");
  }
  else if(r==-1){
	printf("Erro, verifique o PID\n");
  }
  else{
	printf("PID encontrado. Prioridade alterada para %i\n", argv2);
  }
  return 0;
}
