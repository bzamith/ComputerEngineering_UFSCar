// NAO EH PRA RODAR, SO VAMOS VER

#include <omp.h>
#include <stdio.h>

int main(int *argc, char *argv[]){
	#pragma omp parallel shared (A, B, C) private(id) 
	{
		id = omp_get_thread_num();
		A[id] = big_calc(id);
		#pragma omp barrier
		#pragma omp for
		for(i=0;i<N;i++){
			C[i] = big_calc3(i,A);
		}
		// nowait mata o barrier implicito dps do omp for
		#pragma omp for nowait
		for(i=0;i<N;i++){
			B[i] = big_calc2(C,i);
		}		
	}
}