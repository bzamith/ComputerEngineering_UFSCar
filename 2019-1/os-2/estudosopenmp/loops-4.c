// TA DANDO ERRO, PQ?
// PQ X CONTINUA GLOBAL E TEM CONCORRENCIA DE ESCRITA
// TENTANDO RESOLVER COM MUTEX! (MESMO QUE NAO FACA SENTIDO)

#include <omp.h>
#include <stdio.h>

static long num_steps = 100000;
double step;
int main(int *argc, char *argv[]){
	int i;
	double x, pi, sum = 0.0;
	step = 1.0/(double) num_steps;

	#pragma omp parallel for reduction (+:sum) 
	for(i=0;i<num_steps;i++){
		#pragma omp critical
		{
			x = (i+0.5)*step;
			sum += 4.0/(1.0+x*x);
		}
	}

	pi = step*sum;
	printf("%f\n",pi);
}