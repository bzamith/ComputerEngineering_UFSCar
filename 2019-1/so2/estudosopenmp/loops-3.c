// SOLUCAO DO VIDEO
// https://www.youtube.com/watch?v=8jzHiYo49G0&list=PLLX-Q6B8xqZ8n8bwjGdzBJ25X2utwnoEG&index=12

#include <omp.h>
#include <stdio.h>

static long num_steps = 100000;
double step;
int main(int *argc, char *argv[]){
	int i;
	double x, pi, sum = 0.0;
	step = 1.0/(double) num_steps;
	
	#pragma omp parallel
	{
		double x;
		#pragma omp for reduction (+:sum) 
		for(i=0;i<num_steps;i++){
			x = (i+0.5)*step;
			sum += 4.0/(1.0+x*x);
		}
	}
	pi = step*sum;
	printf("%f\n",pi);
}