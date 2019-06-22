// integral de 0 a 1 de 4 / (1+x²), tem que dar pi
// integracao numerica


// TEM ERRO! RACE CONDITION!

#include <omp.h>
#include <stdio.h>

static int num_steps = 40;
double step;
int main(int *argc, char *argv[]){
	double pi, sum = 0.0;
	step = 1.0/(double) num_steps;

	#pragma omp parallel num_threads(num_steps)
	{
		double x = 0.0;
		double i = (double) omp_get_thread_num();
		x = (i+0.5)*step;
		sum = sum + 4.0/(1.0+x*x);
	}

	pi = step*sum;
	printf("%f\n",pi);
}