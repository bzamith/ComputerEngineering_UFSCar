template <class T>

class Pilha
{
public:
	Pilha(int tam);
	~Pilha();
	void Empilha(T X, bool& DeuCerto);
	void Desempilha(T& X, bool& DeuCerto);
	void ImprimePilha();
	int NumeroElementos();
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

template <class T>
int Pilha<T>::NumeroElementos()
{
	Pilha <T> Paux(this->Tamanho);
	int contador = 0;
	bool DeuCerto;
	T x;

	while(this->Vazio() == false){
		this->Desempilha(x,DeuCerto);
		Paux.Empilha(x,DeuCerto);
		contador ++;
	}

	while(Paux.Vazio() == false){
		Paux.Desempilha(x,DeuCerto);
		this->Empilha(x,DeuCerto);
	}

	return contador;
}

template <class T>
void Pilha<T>::ImprimePilha()
{
	Pilha <T> Paux(this->Tamanho);
	bool DeuCerto;
	T x;

	while(this->Vazio() == false){
		this->Desempilha(x,DeuCerto);
		Paux.Empilha(x,DeuCerto);
		cout << x << " ";
	}

	while(Paux.Vazio() == false){
		Paux.Desempilha(x,DeuCerto);
		this->Empilha(x,DeuCerto);
	}
	cout << endl;
}