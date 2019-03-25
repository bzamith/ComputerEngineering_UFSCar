#include <iostream>
#include <stdlib.h>

using namespace std;

class Node
{
public:
	int vertice;
	int fluxo;
	int vertice_pai;
	char sentido;
	bool marcado;
	static int numero;
	Node();
};

Node::Node()
{
	this -> marcado = false;
	this->vertice = numero;
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

void Enfileira(Node elemento,Node fila[], int& fim)
{
	fim++;
	fila[fim] = elemento;
}

Node Desenfileira(Node fila[], int& fim)
{
	Node aux = fila[0];

	if(fim == 0)
	{
		fim --;
	}
	else if(fim != -1)
	{
		for(int i = 1; i <= fim; i++)
		{
			fila[i-1] = fila[i];
		}
		fim --;
	}

	return aux;
}

int FordFulkerson(int *&p, Node Vertices[])
{
	int dimensao = *p;
	int fim = -1;
	int Capacidade[dimensao][dimensao];
	int Fluxo[dimensao][dimensao];
	int restante, contador = 1;
	int fluxo_maximo = 0;
	Node Q[dimensao];
	Node aux;

	for(int i = 0; i < dimensao;i++)
	{
		for(int j = 0; j < dimensao; j ++)
		{
			Capacidade[i][j] = *(p+contador);
			contador++;
		}
	}

	for(int i = 0; i < dimensao; i++)
	{
		for(int j = 0; j< dimensao; j++)
		{
			Fluxo[i][j] = 0;
		}
	}

	Vertices[0].fluxo = 100000;
	Vertices[0].vertice_pai = ' ';
	Vertices[0].sentido = '-';
	Vertices[0].marcado = true;
	Enfileira(Vertices[0],Q,fim);

	while(fim != -1)
	{
		aux = Desenfileira(Q,fim);
		for(int i = 0; i < dimensao; i++)
		{
			if(Capacidade[aux.vertice][i] != -1)
			{
				if(Vertices[i].marcado == false)
				{
					restante = Capacidade[aux.vertice][i] - Fluxo[aux.vertice][i];
					if(restante > 0)
					{
						if(aux.fluxo < restante)
						{
							Vertices[i].fluxo = aux.fluxo;
						}
						else
						{
							Vertices[i].fluxo = restante;
						}
						Vertices[i].vertice_pai = aux.vertice;
						Vertices[i].sentido = '+';
						Vertices[i].marcado = true;
						Enfileira(Vertices[i],Q,fim);
					}
				}
			}
		}

		for(int i = 0; i < dimensao; i++)
		{
			if(Capacidade[i][aux.vertice] != -1)
			{
				if(Vertices[i].marcado == false)
				{
					if(Fluxo[i][aux.vertice] > 0)
					{
						if(aux.fluxo < Fluxo[i][aux.vertice])
						{
							Vertices[i].fluxo = aux.fluxo;
						}
						else
						{
							Vertices[i].fluxo = Fluxo[i][aux.vertice];
						}
						Vertices[i].vertice_pai = aux.vertice;
						Vertices[i].sentido = '-';
						Vertices[i].marcado = true;
						Enfileira(Vertices[i],Q,fim);
					}
				}
			}
		}

		if(Vertices[dimensao - 1].marcado == true)
		{
			int vertice_auxiliar = dimensao - 1;

			while(vertice_auxiliar != 0)
			{
				if(Vertices[vertice_auxiliar].sentido == '+')
				{
					Fluxo[Vertices[vertice_auxiliar].vertice_pai][vertice_auxiliar] += Vertices[dimensao - 1].fluxo;
				}
				else if(Vertices[vertice_auxiliar].sentido == '-')
				{
					Fluxo[vertice_auxiliar][Vertices[vertice_auxiliar].vertice_pai] -= Vertices[dimensao - 1].fluxo;
				}
				vertice_auxiliar = Vertices[vertice_auxiliar].vertice_pai;
			}

			for(int i = 1; i < dimensao; i++)
			{
				Vertices[i].marcado = false;
			}

			fim = -1;
			Enfileira(Vertices[0],Q,fim);
		}
	}

	for(int i = 0;i < dimensao; i++)
	{
		fluxo_maximo += Fluxo[i][dimensao - 1];
	}

	cout << endl << "A matriz de fluxo: " << endl;

	for(int i = 0; i < dimensao; i++)
	{
		for(int j = 0; j < dimensao; j++)
		{
			cout << Fluxo[i][j] << " ";
		}
		cout << endl;
	}

	return fluxo_maximo;
}

int main()
{
	int *Matriz_adjacencia;
	criaGrafo(Matriz_adjacencia);
	Node Vertices[Matriz_adjacencia[0]];
	cout << endl << "O fluxo maximo e: " << FordFulkerson(Matriz_adjacencia,Vertices);
	cout<<endl;
	system("PAUSE");
	return 0;
}
