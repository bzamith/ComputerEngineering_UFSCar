#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char const *argv[]) {
  int pid = cowfork();

  printf(1,"PID = %p\n",pid);

  if(pid==0){
    printf(1,"Processo filho rodando\n");
  }
  else{
    printf(1,"Processo pai rodando\n");
  }
  while (1);
  exit();
}
