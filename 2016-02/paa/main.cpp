#include <SFML/Graphics.hpp>
#include <stdlib.h>
#include "MenuInicial.h"
#include "RecebePalavra.h"
#include "ForcaBruta.h"
#include "Creditos.h"
#include "Horspool.h"
#include "TelaResultado.h"
#include "BoyerMoore.h"
#include "ComparaTempo.h"
#include <string>
#include <iostream>


#define numMaxChar 30

using namespace std;

int main()
{
	sf::RenderWindow window(sf::VideoMode(1000, 660), "StringMatching"); //declara a tela
	int tela = -1; //variavel tela
	int tela2 = 0;
	string palavra, frase;
	bool achou = false;
	bool fimPrograma = false;
	double tempo;
	sf::Clock clock;

	while (!fimPrograma)
	{
		if (tela == -1)
		{
			tela = menuInicial(window);
		}
		if (tela == 1 || tela == 2 || tela == 3 || tela == 4)
		{
			palavra = "";
			frase = "";
			tela2 = digitaTela(window, frase, 1);
			if (tela2 != 0) {
				while (clock.getElapsedTime() < sf::seconds(2.5)) {}
				tela2 = digitaTela(window, palavra, 2);
				if (tela2 == 0) {
					tela = 0;
				}
			}
			else {
				tela = 0;
			}
		}

		if (tela == 0)
		{
			window.close();
			return EXIT_SUCCESS;
		}
		if (tela == 1) {
			achou = forcaBruta(window, palavra, frase);
			tela = -2;
		}
		if (tela == 2) {
			achou = horspool(window, palavra, frase);
			tela = -2;
		}
		if (tela == 3) {
			achou = boyerMoore(window, palavra, frase);
			tela = -2;
		}
		if (tela == 4) {
			tela = comparaTempo(window, palavra, frase);
			if(tela==0)
				break;	
			tela = -1;
		}
		
		if (tela == 5)
		{
			while (clock.getElapsedTime() < sf::seconds(2.5)) {}
			tela = creditos(window);
			if(tela==0)
				break;
		}
		if (tela == -2) {
			tela = telaResultado(window, achou);
			if(tela==0)
				break;
			tela = -1;
		}
	}

	return EXIT_SUCCESS;
}


