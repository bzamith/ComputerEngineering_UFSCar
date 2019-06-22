//gcc -pthread pthreads-1.c 

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
	pthread_t tid0;
	pthread_t tid1;

	pthread_create(&tid0, NULL, threadFunc, NULL);
	pthread_create(&tid1, NULL, threadFunc, NULL);
	
	pthread_join(tid0, NULL);
	pthread_join(tid1, NULL);
}