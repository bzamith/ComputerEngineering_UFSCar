/* 
    export OMP_NUM_THREADS=12
    gcc -fopenmp helloWord-1.c
    ./a.out
*/



#include <omp.h>
#include <stdio.h>

int main(int *argc, char *argv[]){
  #pragma omp parallel num_threads(6)
  {
  	int ID = omp_get_thread_num();
    printf("Hello, I'm thread number %d\n",ID);
    printf("Bye, I'm thread number %d\n", ID);
  }
  return 0;
}