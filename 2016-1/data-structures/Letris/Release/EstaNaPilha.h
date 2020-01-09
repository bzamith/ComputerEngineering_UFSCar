#pragma once
#include<iostream>
#define TAM_LETRAS 50 //tamanho do quadrado das letras
#define DIST_PILHAS 15 //distancia entre as pilhas
#define PALAVRASDISPONIVEIS 10 //qntd de palavras no banco de palavras
#define PALAVRASSELECIONADAS 3 //palavras selecionadas por jogo
#define TAM_PALAVRA 5 //qntd de letras das palavras do banco de palavras

//Esta na Pilha
bool estaNaPilha(Pilha<char> *palavras, string selecionadas[PALAVRASSELECIONADAS]) {
	bool DeuCerto;
	bool AchouPalavra = false;
	int k = 0;
	char X, Y;
	Pilha<char> Paux(palavras->Tamanho);
	Pilha<char> Paux2(palavras->Tamanho);
	Pilha<char> Paux3(palavras->Tamanho);

	for (int i = 0; i<PALAVRASSELECIONADAS; i++) {
		while (palavras->Vazio() == false && k != TAM_PALAVRA) {
			palavras->Desempilha(X, DeuCerto);
			if (X == selecionadas[i][k]) {
				k++;
				Paux2.Empilha(X, DeuCerto);
			}
			else {
				k = 0;
				Y = X;
				while (Paux2.Vazio() == false) {
					Paux2.Desempilha(X, DeuCerto);
					Paux3.Empilha(X, DeuCerto);
				}
				while (Paux3.Vazio() == false) {
					Paux3.Desempilha(X, DeuCerto);
					Paux.Empilha(X, DeuCerto);
				}
				Paux.Empilha(Y, DeuCerto);
			}
		}
		if (k == TAM_PALAVRA) {
			while (Paux.Vazio() == false) {
				Paux.Desempilha(X, DeuCerto);
				palavras->Empilha(X, DeuCerto);
			}
			AchouPalavra = true;
		}
		else {
			k = 0;
			while (Paux2.Vazio() == false) {
				Paux2.Desempilha(X, DeuCerto);
				Paux3.Empilha(X, DeuCerto);
			}
			while (Paux3.Vazio() == false) {
				Paux3.Desempilha(X, DeuCerto);
				Paux.Empilha(X, DeuCerto);
			}
			while (Paux.Vazio() == false) {
				Paux.Desempilha(X, DeuCerto);
				if (X == selecionadas[i][k]) {
					k++;
					Paux2.Empilha(X, DeuCerto);
				}
				else {
					k = 0;
					Y = X;
					if (X == selecionadas[i][k]) {
						while (Paux2.Vazio() == false) {
							Paux2.Desempilha(X, DeuCerto);
							Paux3.Empilha(X, DeuCerto);
						}
						while (Paux3.Vazio() == false) {
							Paux3.Desempilha(X, DeuCerto);
							palavras->Empilha(X, DeuCerto);
						}
						Paux2.Empilha(Y, DeuCerto);
						k++;
					}
					else {
						while (Paux2.Vazio() == false) {
							Paux2.Desempilha(X, DeuCerto);
							Paux3.Empilha(X, DeuCerto);
						}
						while (Paux3.Vazio() == false) {
							Paux3.Desempilha(X, DeuCerto);
							palavras->Empilha(X, DeuCerto);
						}
						palavras->Empilha(Y, DeuCerto);
					}
				}
			}
			if (k < TAM_PALAVRA) {
				while (Paux2.Vazio() == false) {
					Paux2.Desempilha(X, DeuCerto);
					Paux3.Empilha(X, DeuCerto);
				}
				while (Paux3.Vazio() == false) {
					Paux3.Desempilha(X, DeuCerto);
					palavras->Empilha(X, DeuCerto);
				}
			}
			else if (k == TAM_PALAVRA) {
				AchouPalavra = true;
			}
		}
	}
	return AchouPalavra;
}