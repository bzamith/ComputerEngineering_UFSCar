/*Autores(Grupo 5):
 * Bruna Zamith Santos, 629093
 * Henrique Frajacomo, 726536
 * Joao Victor Pacheco, 594970 
 * Marcos Augusto Faglioni Junior, 628301
*/

//Definicoes
#define __USE_GNU 1 
#define max_renas 9 //Numero maximo total de renas
#define max_elfos 3 //Numero maximo de elfos ajudados por vez

//Bibliotecas
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> //Para size_t e NULL pointer definition
#include <semaphore.h>

//Semaforos
sem_t mutex_contadores; //Mutex para controlar a alteracao dos contadores (de elfos e de renas)
sem_t semaforo_elfos; //Previne que mais elfos entrem enquanto tres estao sendo ajudados
sem_t semaforo_santa; //Semaforo para indicar quando Santa Claus esta disponivel


//Variaveis globais
int elfos = 0; //Numero de elfos 
int renas = 0; //Numero de renas
int elfos_total = 0; //Numero maximo de elfos a ser indicado pelo usuario

//Função da Santa Claus
void* funcao_santa(void* v){
  sem_wait(&semaforo_santa); //Espera semaforo_santa (garante que outra thread nao esta usando ela)
  sem_wait(&mutex_contadores); //Espera mutex_contador (para ter certeza que nao vai ter concorrencia de alteracao)
  if(renas == max_renas){ //Se o numero de renas for igual ao numero maximo, o treno pode ser preparado
    printf("Treno preparado!\n"); //Prepara o treno
    for(int i=0; i<max_renas; i++){ //Depois que o treno foi preparado, o numero de renas eh decrementado até 0
      renas--;
    }
  } else if(elfos == max_elfos){ //Se o numero de elfos for igual ao numero maximo (3), os elfos podem ser ajudados
    printf("Elfos Ajudados!\n"); //Ajuda os elfos
    for(int i=0; i<max_elfos; i++){ //Depois que os elfos foram ajudados, o numero de elfos eh decrementado ate 0
      elfos--;
    }
  }
  sem_post(&mutex_contadores); //Libera o mutex_contador
  sem_post(&semaforo_santa); //Libera o semaforo_santa
  return NULL;
}

//Funcao dos Elfos
// Sem parametros e sem retorno
void* funcao_elfos(void* v){
  for(int i=0; i<elfos_total; i++){ //Elfos_total eh definido pelo usuario, numero maximo de execucoes da funcao dos elfos
    if(elfos < max_elfos){ //Se o numero de elfos for menor que o numero maximo
      sem_wait(&mutex_contadores); //Espera mutex_contador  
      elfos ++; //Incrementa o numero de elfos
      printf("O numero de elfos eh: %i\n",elfos); //Printa o numero de elfos atual
      sem_post(&mutex_contadores); //Libera mutex_contador  
    }
    if(elfos == max_elfos && renas<max_renas){ //Se atingir o numero maximo de elfos e o numero de renas tambem nao for o maximo
      sem_wait(&semaforo_elfos); //Espera para ver se os elfos nao estao ja sendo ajudados
      printf("Os elfos chamaram Santa!\n"); //Senao, chama a Santa
      funcao_santa(NULL);   //Se numero de elfos for igual ao numero maximo de elfos, chama a funcao funcao_santa afim de liberar as elfos
      printf("%i elfos ajudados!\n",max_elfos); //Printa o numero de elfos ajudados
      sem_post(&semaforo_elfos); //Libera o semaforo_elfos
    }
  	sleep(2); //Tempo para a execucao de outras threads
  }
  return NULL;
}

//Funcao das Renas:
// Sem parametros e sem retorno
void* funcao_renas(void* v){
  for(int i=0; i<max_renas; i++){  //Enquanto o numero maximo de renas nao for atingido, roda o loop
    if(renas < max_renas){ //Se o numero de renas for menor que o numero maximo
      sem_wait(&mutex_contadores); //Espera mutex_contador  
      renas ++; //Incrementa o numero de renas
	  printf("O numero de renas eh: %i\n",renas); //Printa o numero de renas atual
      sem_post(&mutex_contadores); //Libera mutex_contador
    }
    if(renas == max_renas){ //Se atingir o numero maximo de renas
      printf("As renas chamaram Santa!\n"); //Chama a Santa
      funcao_santa(NULL);  //Se numero de renas for igual ao numero maximo de renas, chama a funcao funcao_santa afim de liberar as renas
      printf("As renas foram amarradas e liberadas!\n"); //As renas sao amarradas e liberadas
    }  
    sleep(3); //Tempo para a execucao de outras threads
  }
  return NULL;
}

//Funcao principal
int main(int argc, char *argv[]){ 
  //Declara as threads
  pthread_t thr_santa, thr_elfos, thr_renas;

  //Recebe o numero de elfos como argumento do processo
	if(argc != 2){
		printf("Digite o numero de elfos na chamada da funcao!\n");
		return -1;
    }
	elfos_total = atoi(argv[1]);	
  
  //Inicializa o mutex com 1
  sem_init(&mutex_contadores, 0, 1); 
  
  //Inicializa os semaforos com 1
  sem_init(&semaforo_santa, 0, 1);
  sem_init(&semaforo_elfos, 0, 1);
  
  //Cria as threads e instanciacao das funcoes elfos e renas
  pthread_create(&thr_elfos, NULL, funcao_elfos, NULL);
  pthread_create(&thr_renas, NULL, funcao_renas, NULL);
  
  //Join - Sincroniza todas as threads a fim de serem finalizadas antes de encerrar o codigo
  pthread_join(thr_elfos, NULL); 
  pthread_join(thr_renas, NULL);
           
  //Destroi os semaforos e mutexes 
  sem_destroy(&mutex_contadores);
  sem_destroy(&semaforo_elfos);    
  sem_destroy(&semaforo_santa);    
           
  //Finaliza o programa
  return 0;
}


