// NAO EH PRA RODAR, SO VAMOS VER

#include <omp.h>
#include <stdio.h>

int main(int *argc, char *argv[]){
	#pragma omp parallel shared (A, B, C) private(id) 
	{
		do_many_things();
		// poderia usar o nowait dps do single
		#pragma omp single
		{
			exchange_boundaries();
		}
		do_many_other_things();
	}
}