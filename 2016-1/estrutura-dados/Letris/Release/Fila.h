#pragma once
#include<iostream>
#include<stdio.h>
#include<vector>
#include<string>
#include<cstdlib>
#include<time.h>
#include<stdlib.h>

using namespace std;

//Fila
//------------------------------------------------------------------------------------------------------------------------------
typedef struct
{
	int Tamanho;
	int ultimoElemento;
	char Elementos[];
}Fila;


void Enfileira(Fila& F, char X, bool& DeuCerto);
void Desenfileira(Fila& F, char& X, bool& DeuCerto);
bool Vazio(Fila F);
bool Cheia(Fila F);
void Cria(Fila& F, const int qElementos);


void Enfileira(Fila& F, char X, bool& DeuCerto)
{
	if (Cheia(F))
	{
		DeuCerto = false;
	}
	else
	{
		F.ultimoElemento++;
		F.Elementos[F.ultimoElemento] = X;
		DeuCerto = true;
	}
}


void Desenfileira(Fila& F, char& X, bool& DeuCerto)
{
	if (Vazio(F))
	{
		DeuCerto = false;
	}
	else
	{
		X = F.Elementos[0];

		for (int i = 0; i<F.ultimoElemento; i++)
		{
			F.Elementos[i] = F.Elementos[i + 1];
		}

		F.ultimoElemento--;

		DeuCerto = true;
	}
}


bool Vazio(Fila F)
{
	if (F.ultimoElemento < 0)
		return true;
	else
		return false;
}


bool Cheia(Fila F)
{
	if (F.ultimoElemento >= F.Tamanho - 1)
		return true;
	else
		return false;
}


void Cria(Fila& F, int qElementos)
{
	F.ultimoElemento = -1;
	F.Tamanho = qElementos;
	//F.Elementos[F.Tamanho];
}
