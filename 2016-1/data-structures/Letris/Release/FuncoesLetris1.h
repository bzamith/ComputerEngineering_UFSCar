#pragma once
#include<iostream>
#include<stdio.h>
#include<vector>
#include<string>
#include<cstdlib>
#include<stdlib.h>
#include<time.h>
#include "Pilha.h"


#ifndef NUM_LETRAS
#define NUM_LETRAS 300 //numero maximo de quadrados que o jogo aceita, se passar disso, o jogo deverá finalizar e o jogador perde
#endif
#ifndef TAM_LETRAS
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#endif
#ifndef QTD_LETRAS
#define QTD_LETRAS 16 //qntd de letras diferentes
#endif
#ifndef DIST_PILHAS
#define DIST_PILHAS 15 //distancia entre as pilhas
#endif
#ifndef TAMY
#define TAMY 10 //numero maximo em y
#endif
#ifndef FIM
#define FIM (TAM_LETRAS*TAMY) //posicao da tela que indica o final dela
#endif
#ifndef BORDAESQ
#define BORDAESQ 0 //define o limite lateral esquerdo
#endif
#ifndef PALAVRASDISPONIVEIS
#define PALAVRASDISPONIVEIS 10 //qntd de palavras no banco de palavras
#endif
#ifndef PALAVRASSELECIONADAS
#define PALAVRASSELECIONADAS 3 //palavras selecionadas por jogo
#endif
#ifndef QTD_PILHAS
#define QTD_PILHAS 6 //numero de colunas (pilhas) do jogo
#endif
#ifndef BORDADIR
#define BORDADIR (QTD_PILHAS-1)*(TAM_LETRAS+DIST_PILHAS) //define o limite lateral direito
#endif
#ifndef INI
#define INI ((QTD_PILHAS*(TAM_LETRAS+DIST_PILHAS))-BORDAESQ)/2 //define o inicio
#endif

using namespace std;

//Palavras Selecionadas
void palavrasSelecionadas(string bancoPalavras[PALAVRASDISPONIVEIS], string selecionadas[PALAVRASSELECIONADAS])
{
	int contador = 0;
	int randomNumber;
	int randomPalavras[PALAVRASSELECIONADAS] = { 0,0,0 };
	bool verifica = 0;
	time_t seconds;
	time(&seconds);
	srand((unsigned int)seconds);

	randomPalavras[0] = rand() % 10;

	while (verifica != 1) {
		randomNumber = rand() % 10;
		if (contador == 0 && (randomNumber != randomPalavras[0])) {
			randomPalavras[1] = randomNumber;
			contador = 1;
			randomNumber = rand() % 10;
		}
		if (contador == 1 && (randomNumber != randomPalavras[0] && randomNumber != randomPalavras[1])) {
			randomPalavras[2] = randomNumber;
			verifica = 1;
		}

	}
	selecionadas[0] = bancoPalavras[randomPalavras[0]];
	selecionadas[1] = bancoPalavras[randomPalavras[1]];
	selecionadas[2] = bancoPalavras[randomPalavras[2]];
}

//Sorteia letras
char sorteiaLetras(char letras[QTD_LETRAS]) {
	int a = rand() % QTD_LETRAS;
	if (rand() % 20 < PALAVRASSELECIONADAS)
		return '*';
	else
		return letras[a];
}
