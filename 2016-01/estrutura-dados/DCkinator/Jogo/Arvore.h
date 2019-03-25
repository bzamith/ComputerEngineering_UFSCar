#pragma once
#include<iostream>


//##############CLASSE N�##############
class Node {
public:
	int info; //informa��o
	Node* dir; //direita
	Node* esq; //esquerda
	Node() { //construtor padr�o
		info = NULL;
		dir = NULL;
		esq = NULL;
	}
	Node(int i) { //construtor com info
		info = i;
		dir = NULL;
		esq = NULL;
	}
};

//##############TIPO PONTEIRO PARA N�##############
typedef Node* ArvoreBinaria;

//##############X EST� NA ARVORE?##############
bool busca(ArvoreBinaria R, int x) {
	if (R == NULL)
		return false;
	else if (R->info == x)
		return true;
	else if (R->info > x)
		return busca(R->esq, x);
	else
		return busca(R->dir, x);
}

//##############IMPRIME TODOS PR�-ORDEM##############
void imprimeTodosPreOrdem(ArvoreBinaria R) {
	if (R != NULL) {
		cout << R->info << endl;
		imprimeTodosPreOrdem(R->esq);
		imprimeTodosPreOrdem(R->dir);
	}
}

//##############IMPRIME TODOS IN ORDEM##############
void imprimeTodosInOrdem(ArvoreBinaria R) {
	if (R != NULL) {
		imprimeTodosInOrdem(R->esq);
		cout << R->info << endl;
		imprimeTodosInOrdem(R->dir);
	}
}

//##############SOMA DOS ELEMENTOS##############
int soma(ArvoreBinaria R) {
	if (R == NULL)
		return 0;
	else {
		return R->info + soma(R->dir) + soma(R->esq);
	}
}

//##############N�S COM UM �NICO FILHO##############
int numeroUnicoFilho(ArvoreBinaria R) {
	if (R == NULL)
		return 0;
	else if ((R->dir == NULL && R->esq != NULL) || (R->esq == NULL && R->dir != NULL))
		return (1 + numeroUnicoFilho(R->esq) + numeroUnicoFilho(R->dir));
	else
		return 0;
}

//##############VERIFICA SE DUAS �RVORES S�O IGUAIS##############
bool saoIguais(ArvoreBinaria R, ArvoreBinaria R2) {
	if (R == NULL && R2 == NULL) {
		return true;
	}
	else if ((R == NULL && R2 != NULL) || (R != NULL && R2 == NULL)) {
		return false;
	}
	else if (R->info == R2->info) {
		if (saoIguais(R->esq, R2->esq) && saoIguais(R->dir, R2->dir))
			return true;
	}
	else {
		return false;
	}
}

//##############� ABB?##############
bool ehABB(ArvoreBinaria R) {
	if (R == NULL) //R � nulo?
		return true;
	else if (R->esq != NULL && R->dir != NULL) { //
		if ((R->info > R->esq->info) && (R->info < R->dir->info)) {
			if (ehABB(R->dir) && ehABB(R->esq))
				return true;
			else
				return false;
		}
	}
	else if (R->esq == NULL && R->dir != NULL) {
		if (R->info < R->dir->info) {
			if (ehABB(R->dir) && ehABB(R->esq))
				return true;
			else
				return false;
		}
	}
	else if (R->esq != NULL && R->dir == NULL) {
		if (R->info > R->esq->info) {
			if (ehABB(R->dir) && ehABB(R->esq))
				return true;
			else
				return false;
		}
	}
	else if (R->esq == NULL && R->dir == NULL)
		return true;
	else
		return false;
}

//##############INSERE N�##############
void insereNo(ArvoreBinaria &R, int x) {
	ArvoreBinaria P;
	if (R == NULL) {
		P = new Node;
		P->info = x;
		P->dir = NULL;
		P->esq = NULL;
		R = P;
		P = NULL;
	}
	else if (R->info > x) {
		insereNo(R->esq, x);
	}
	else if (R->info < x) {
		insereNo(R->dir, x);
	}
}

//##############� FINAL##############
bool ehfinal(Node *novo) {
	if (novo->dir == NULL && novo->esq == NULL)
		return true;
	else
		return false;
}
