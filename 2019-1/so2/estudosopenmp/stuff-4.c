// NAO EH PRA RODAR, SO VAMOS VER

#include <omp.h>
#include <stdio.h>

int main(int *argc, char *argv[]){
	#pragma omp parallel 
	{
		#pragma omp sections
		{
			#pragma omp section
			x_calculation();
			#pragma omp section
			y_calculation();
			#pragma omp section
			z_calculation();
		}
	}
}