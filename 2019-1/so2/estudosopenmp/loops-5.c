// TA DANDO ERRO, PQ?
// PQ X CONTINUA GLOBAL E TEM CONCORRENCIA DE ESCRITA
// TENTANDO RESOLVER COM MUTEX! (MESMO QUE NAO FACA SENTIDO)

#include <omp.h>
#include <stdio.h>

double step;
int main(int *argc, char *argv[]){
	int i;
	double x, pi, sum = 0.0;
	step = 1.0/(double) omp_get_max_threads();

	#pragma omp parallel shared(sum) private(x)
	{
			i = omp_get_thread_num();
			x = (i+0.5)*step;
			#pragma omp critical
			sum += 4.0/(1.0+x*x);
	}
	pi = step*sum;
	printf("%f\n",pi);
}