// integral de 0 a 1 de 4 / (1+x²), tem que dar pi
// integracao numerica

// MEU EXEMPLO RESOLVIDO!
// PRECISO CHECAR SE O NUMERO DE THREADS QUE EU PEDI FOI DE FATO O QUE DERAM
// PODE MUDAR!
// FALSE SHARING!


#include <omp.h>
#include <stdio.h>

static int num_steps = 40;
double step;
int main(int *argc, char *argv[]){
	int num_threads;
	double pi, final_sum = 0.0;
	double sum[num_steps];
	step = 1.0/(double) num_steps;

	#pragma omp parallel num_threads(num_steps)
	{
		double x = 0.0;
		int i = omp_get_thread_num();
		if (i==0) num_threads = omp_get_num_threads();
		x = ((double)i+0.5)*step;
		sum[i] = 4.0/(1.0+x*x);
	}

	for(int i=0; i<num_threads; i++){
		final_sum += sum[i];
	}

	pi = step*final_sum;
	printf("%f\n",pi);
}