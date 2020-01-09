//gcc -pthread pthreads-1.c 
// SE USAR VETOR ELE VAI PRINTAR O ENDERECO  BASE NEH

#define _GNU_SOURCE
#include<stdio.h>
#include<pthread.h>
#define NUM_THREADS 8

void *threadFunc (void *arg){
	pthread_t self = pthread_self();	
	printf("Thread number %ld\n", self);
	pthread_exit(NULL);	
}

int main(void){
	int i=0;
	pthread_t tid[NUM_THREADS];

	pthread_create(&tid[i], NULL, threadFunc, NULL);
	for(i=1; i<NUM_THREADS; i++){
		pthread_join(tid[i-1], NULL);
		pthread_create(&tid[i], NULL, threadFunc, NULL);
	}
	pthread_join(tid[i-1], NULL);
}