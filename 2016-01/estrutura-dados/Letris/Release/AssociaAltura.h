#pragma once
#include<iostream>
#ifndef TAM_LETRAS
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#endif
#ifndef DIST_PILHAS
#define DIST_PILHAS 15 //distancia entre as pilhas
#endif

//associa a textura à letra
int associaAltura(float y, Pilha<char> *pilha0, Pilha<char> *pilha1, Pilha<char> *pilha2, Pilha<char> *pilha3, Pilha<char> *pilha4, Pilha<char> *pilha5) {
	if (y == TAM_LETRAS * 0) {
		return 0;
	}
	if (y == TAM_LETRAS * 1) {
		return 1;
	}
	if (y == TAM_LETRAS * 2) {
		return 2;
	}
	if (y == TAM_LETRAS * 3) {
		return 3;
	}
	if (y == TAM_LETRAS * 4) {
		return 4;
	}
	if (y == TAM_LETRAS * 5) {
		return 5;
	}
	if (y == TAM_LETRAS * 6) {
		return 6;
	}
	if (y == TAM_LETRAS * 7) {
		return 7;
	}
	if (y == TAM_LETRAS * 8) {
		return 8;
	}
	if (y == TAM_LETRAS * 9) {
		return 9;
	}
	if (y == TAM_LETRAS * 10) {
		return 10;
	}
}