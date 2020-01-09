#pragma once
#include<iostream>
#include<stdio.h>
#include<vector>
#include<string>
#include<cstdlib>
#include<stdlib.h>

//Pilha
//-----------------------------------------------------------------------------------------------------------------
template <class T>

class Pilha
{
public:
	Pilha(int tam);
	~Pilha();
	void Empilha(T X, bool& DeuCerto);
	void Desempilha(T& X, bool& DeuCerto);
	bool Vazio();
	bool Cheia();

	int Tamanho;
	int Topo;
	T* Elementos;
};

template <class T>
Pilha<T>::Pilha(int tam)
{
	if (tam > 0)
		Tamanho = tam;
	else
		Tamanho = 10;

	Topo = -1;
	Elementos = new T[Tamanho];
}

template <class T>
Pilha<T>::~Pilha()
{
	delete[] Elementos;
}

template <class T>
void Pilha<T>::Empilha(T X, bool& DeuCerto)
{
	if (Cheia())
	{
		DeuCerto = false;
	}
	else
	{
		Topo++;
		Elementos[Topo] = X;
		DeuCerto = true;
	}
}

template <class T>
void Pilha<T>::Desempilha(T& X, bool& DeuCerto)
{
	if (Vazio())
	{
		DeuCerto = false;
	}
	else
	{
		X = Elementos[Topo];
		Topo--;
		DeuCerto = true;
	}
}

template <class T>
bool Pilha<T>::Vazio()
{
	if (Topo < 0)
		return true;
	else
		return false;
}

template <class T>
bool Pilha<T>::Cheia()
{
	if (Topo >= Tamanho - 1)
		return true;
	else
		return false;
}