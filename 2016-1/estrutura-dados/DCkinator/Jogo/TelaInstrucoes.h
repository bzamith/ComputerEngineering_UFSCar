#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
using namespace std;

int telaInstrucoes(sf::RenderWindow &window) {
	int tela = -1; //inicializa a variavel tela
	
	sf::Texture fundo; //textura instrucoes
	fundo.loadFromFile("instrucoes.png"); //fundo instrucoes
	sf::Sprite instrucoes; //declara a sprite
	//set texturas
	instrucoes.setTexture(fundo);
	//set posição inicial
	instrucoes.setPosition(0, 0);

	window.draw(instrucoes); //desenha o menu 0
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
				if (event.key.code == sf::Keyboard::Space) { //espaço equivale a enter
					tela = 1;
					return tela;
				}
			}
			window.draw(instrucoes); //desenha o atual
			window.display(); //display da tela
		}
	}
}