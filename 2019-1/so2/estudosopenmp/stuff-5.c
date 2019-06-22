// NAO EH PRA RODAR, SO VAMOS VER

#include<omp.h>

void main()
{
	int num_threads;
	omp_set_dynamic(0);
	omp_set_num_threads(omp_num_procs());
	#pragma omp parallel
	{
		int id = omp_get_thread_num();
		#pragma omp single
		num_threads = omp_get_num_threads();
		do_lots_of_stuff(id);
	}
}