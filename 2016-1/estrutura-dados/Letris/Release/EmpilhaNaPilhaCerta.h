#pragma once
#include<iostream>
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#define DIST_PILHAS 15 //distancia entre as pilhas

//associa a textura à letra
int empilhaNaPilhaCerta(float x, int sorteia, Pilha<char> *pilha0, Pilha<char> *pilha1, Pilha<char> *pilha2, Pilha<char> *pilha3, Pilha<char> *pilha4, Pilha<char> *pilha5) {
	int distanciaTotal = TAM_LETRAS + DIST_PILHAS;
	bool DeuCerto;
	if (x == 0) {
		pilha0->Empilha(sorteia, DeuCerto);
		return 0;
	}
	if (x == distanciaTotal) {
		pilha1->Empilha(sorteia, DeuCerto);
		return 1;
	}
	if (x == distanciaTotal * 2) {
		pilha2->Empilha(sorteia, DeuCerto);
		return 2;
	}
	if (x == distanciaTotal * 3) {
		pilha3->Empilha(sorteia, DeuCerto);
		return 3;
	}
	if (x == distanciaTotal * 4) {
		pilha4->Empilha(sorteia, DeuCerto);
		return 4;
	}
	if (x == distanciaTotal * 5) {
		pilha5->Empilha(sorteia, DeuCerto);
		return 5;
	}
}