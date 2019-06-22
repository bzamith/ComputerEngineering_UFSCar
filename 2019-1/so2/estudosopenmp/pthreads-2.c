//gcc -pthread pthreads-1.c 
// POR QUE NAO COMECA A PRINTAR DO 0? PQ A MAIN QUE EH 0? NAO ENTENDI!

#define _GNU_SOURCE
#include<stdio.h>
#include<pthread.h>
#define NUM_THREADS 8

void *threadFunc (void *pArg){
	int *p = (int*) pArg;
	int myNum = *p;
	printf("Thread number %d\n", myNum);
	pthread_exit(NULL);
}

int main(void){
	int i=0;
	pthread_t tid[NUM_THREADS];

	pthread_create(&tid[i], NULL, threadFunc, &i);
	for(i=1; i<NUM_THREADS; i++){
		pthread_join(tid[i-1], NULL);
		pthread_create(&tid[i], NULL, threadFunc, &i);
	}
	pthread_join(tid[i-1], NULL);
}