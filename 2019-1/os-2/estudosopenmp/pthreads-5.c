//gcc -pthread pthreads-1.c 
// Agr funciona!

#define _GNU_SOURCE
#include<stdio.h>
#include<pthread.h>
#define NUM_THREADS 8

void *threadFunc (void *pArg){
	int myNum = *((int*)pArg);
	printf("Thread number %d\n", myNum);
	pthread_exit(NULL);
}

int main(void){
	int i=0;
	pthread_t tid[NUM_THREADS];

	for(i=1; i<NUM_THREADS; i++){
		tid[i] = i;;
		pthread_create(&tid[i], NULL, threadFunc, &i);
	}
	
	for(i=1; i<NUM_THREADS; i++){
		pthread_join(tid[i], NULL);
	}
}