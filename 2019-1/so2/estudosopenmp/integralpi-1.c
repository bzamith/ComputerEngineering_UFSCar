/* 
    export OMP_NUM_THREADS=12
    gcc -fopenmp helloWord-1.c
    ./a.out
*/


// integral de 0 a 1 de 4 / (1+x²), tem que dar pi
// integracao numerica


#include <omp.h>
#include <stdio.h>

static long num_steps = 100000;
double step;
int main(int *argc, char *argv[]){
	int i;
	double x, pi, sum = 0.0;

	step = 1.0/(double) num_steps;

	for(i=0;i<num_steps;i++){
		x = (i+0.5)*step;
		sum = sum + 4.0/(1.0+x*x);
	}

	pi = step*sum;
	printf("%f\n",pi);
}