// integral de 0 a 1 de 4 / (1+x²), tem que dar pi
// integracao numerica

// RESPOSTA DO VIDEO
// https://www.youtube.com/watch?v=OuzYICZUthM&list=PLLX-Q6B8xqZ8n8bwjGdzBJ25X2utwnoEG&index=7


#include <omp.h>
#include <stdio.h>

static long num_steps = 100000;
double step;
#define NUM_THREADS 2

int main(int *argc, char *argv[]){
	int i, nthreads;
	double pi, sum[NUM_THREADS];

	step = 1.0/(double) num_steps;

	omp_set_num_threads(NUM_THREADS);

	#pragma omp parallel
	{
		int i, id, nthrds;
		double x;
		id = omp_get_thread_num();
		nthrds = omp_get_num_threads();
		if (id==0) nthreads = nthrds;
		for(i=id, sum[i]=0.0; i<num_steps; i=i+nthrds){
			x = (i+0.5)*step;
			sum[id] += 4.0/(1.0+x*x);
		}
	}

	for(i=0, pi=0.0; i<nthreads; i++) pi += sum[i]*step;
	printf("%f - %i\n",pi, nthreads);
}