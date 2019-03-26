#include <iostream>
#include<stdlib.h>

using namespace std;

class Node
{
public:
	int Distancia;
	char Vertice;
	char Vertice_pai;
	bool EstaNaArvore;
	static int numero;
	Node();
};

Node::Node()
{
	this -> Distancia = -1;
	this -> Vertice_pai = '-';
	this -> Vertice = numero + 97;
	this -> EstaNaArvore = false;
	numero++;
}

int Node::numero = 0;

void criaGrafo(int *&p)
{
	int dimensao;
	cout << "Insira o numero de vertices do grafo: ";
	cin >> dimensao;
	cout << endl;

	p = new int[dimensao*dimensao + 1];

	*p = dimensao;

	for(int i = 1; i < dimensao * dimensao + 1; i++)
	{
			cout << "Insira o elemento: ";
			cin >> *(p + i) ;
	}
}

void imprimeMatriz(int *p)
{
	int dimensao = p[0];

	for(int i = 1; i < dimensao * dimensao + 1; i++)
	{
		cout << p[i] << " ";

		if(i % dimensao == 0)
			cout << endl;
	}
}

void Djikstra(int *&p, Node arvore[])
{
	char raiz;
	int num_nos = *p;
	int contador = 0;
	int menor_distancia;
	char Node_menor_distancia;
	char Ultimo_node;
	cout << endl;
	cout << "Insira o primeiro node: ";
	cin >> raiz;
	cout << endl;

	arvore[raiz - 97].EstaNaArvore = true;
	arvore[raiz - 97].Distancia = 0;
	Ultimo_node = raiz;

	for(int k = 0; k < num_nos ; k++)
	{
		contador = 0;
		for(int i = 0 ; i < num_nos ; i++)
		{
			if(*(p + num_nos*(Ultimo_node - 97) + 1 + i) != -1 && arvore[i].EstaNaArvore == false)
			{
				if(arvore[i].Distancia == -1 || *(p + num_nos*(Ultimo_node - 97) + 1 + i) + arvore[Ultimo_node - 97].Distancia < arvore[i].Distancia )
				{
					arvore[i].Distancia = *(p + num_nos*(Ultimo_node - 97) + 1 + i) + arvore[Ultimo_node - 97].Distancia;
					arvore[i].Vertice_pai = Ultimo_node;
				}
			}
		}

		while(arvore[contador].EstaNaArvore == true || arvore[contador].Distancia == -1)
		{
			contador++;
		}

		menor_distancia = arvore[contador].Distancia;
		Node_menor_distancia = arvore[contador].Vertice;

		for(int j = 0; j < num_nos; j++)
		{
			if(arvore[j].EstaNaArvore == false && arvore[j].Distancia != -1 && arvore[j].Distancia < menor_distancia)
			{
				menor_distancia = arvore[j].Distancia;
				Node_menor_distancia = arvore[j].Vertice;
			}
		}

		Ultimo_node = Node_menor_distancia;
		arvore[Ultimo_node - 97].EstaNaArvore = true;
	}
}

void Imprime_Arvore(int *&p, Node arvore[])
{
	int num_nos = *p;

	for(int i = 0; i < num_nos; i++)
	{
		cout << "Vertice: " << arvore[i].Vertice << endl;
		cout << "Vertice pai: " << arvore[i].Vertice_pai << endl;
		cout << "Distancia: " << arvore[i].Distancia << endl;
		cout << endl;
	}
}

int main()
{
	int *Matriz_adjacencia;
	criaGrafo(Matriz_adjacencia);
	//imprimeMatriz(Matriz_adjacencia);
	Node Arvore[Matriz_adjacencia[0]];
	Djikstra(Matriz_adjacencia,Arvore);
	Imprime_Arvore(Matriz_adjacencia,Arvore);
	system("PAUSE");
	return 0;
}
