// NAO EH PRA RODAR, SO VAMOS VER

#include <omp.h>
#include <stdio.h>

int main(int *argc, char *argv[]){
	#pragma omp parallel shared (A, B, C) private(id) 
	{
		do_many_things();
		// so a master thread vai fazer
		#pragma omp master
		{
			exchange_boundaries();
		}
		#pragma omp barrier
		do_many_other_things();
	}
}