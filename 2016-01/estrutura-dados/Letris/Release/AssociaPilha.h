#pragma once
#include "EstaNaPilha.h"
#pragma once
#include<iostream>
#ifndef TAM_LETRAS
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#endif
#ifndef DIST_PILHAS
#define DIST_PILHAS 15 //distancia entre as pilhas
#endif

//associa a textura à letra
int associaPilha(float x, Pilha<char> *pilha0, Pilha<char> *pilha1, Pilha<char> *pilha2, Pilha<char> *pilha3, Pilha<char> *pilha4, Pilha<char> *pilha5) {
	int distanciaTotal = TAM_LETRAS + DIST_PILHAS;
	if (x == 0) {
		return 0;
	}
	if (x == distanciaTotal) {
		return 1;
	}
	if (x == distanciaTotal * 2) {
		return 2;
	}
	if (x == distanciaTotal * 3) {
		return 3;
	}
	if (x == distanciaTotal * 4) {
		return 4;
	}
	if (x == distanciaTotal * 5) {
		return 5;
	}
}