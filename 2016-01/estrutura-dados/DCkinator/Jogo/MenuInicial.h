#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
using namespace std;

int menuInicial(sf::RenderWindow &window) {
	int tela = -1; //inicializa a variavel tela
	sf::Texture fundo; //textura do fundo 0
	sf::Texture fundo1; //textura do fundo 1 (primeira seta) 
	sf::Texture fundo2; //textura do fundo 2 (segunda seta)
	fundo.loadFromFile("menu.png"); //fundo do menu 0
	fundo1.loadFromFile("menu1.png"); //fundo do menu 1
	fundo2.loadFromFile("menu2.png"); //fundo do menu 2
	sf::Sprite menu; //declara a sprite
	sf::Sprite atual;
	//set texturas
	menu.setTexture(fundo);
	//set posição inicial
	menu.setPosition(0, 0);
	//atual recebe o fundo do menu 0
	atual.setTexture(fundo);
	atual.setPosition(0, 0);
	
	int contador = 0; //variavel contador
	window.draw(menu); //desenha o menu 0
	window.display(); //display da tela

	while (tela != 0) { //tela começa com -1 e só é 0 quando fecha
		sf::Event event; //evento
		while (window.pollEvent(event)) //enquanto receber um evento
		{	
			if (event.type == sf::Event::Closed) { //fecha
				tela = 0;
				return tela;
			}
			
			if (event.type == sf::Event::KeyPressed) { //pressiona uma tecla
				if (event.key.code == sf::Keyboard::Down) { //para baixo
					contador = contador + 1; //aumenta o contador -> ímpar
					if (contador % 2 != 0) //se não divisivel por 2 (impar), é seta 1
						atual.setTexture(fundo1);
					if (contador % 2 == 0) //se divisivel por 2 (par), é seta 2
						atual.setTexture(fundo2);
				}
				if (event.key.code == sf::Keyboard::Up) { //para cima
					contador = contador - 1;  //diminui o contador -> par
					if (contador % 2 != 0) //se não divisivel por 2 (impar), é seta 1
						atual.setTexture(fundo1);
					if (contador % 2 == 0) //se divisivel por 2(impar), é par
						atual.setTexture(fundo2);
				}
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					if (contador % 2 != 0) //se impar, vai pra tela da seta 1
						tela = 1;
					if (contador % 2 == 0) //se par, vai pra tela da seta 2
						tela = 2;
					return tela;
				}
			}
		}
		window.draw(atual); //desenha o atual
		window.display(); //display da tela
	}
}