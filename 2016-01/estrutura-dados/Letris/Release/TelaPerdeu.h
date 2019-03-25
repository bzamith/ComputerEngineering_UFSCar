#pragma once
#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

void telaPerdeu(sf::RenderWindow &window, int &pontuacao) {
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc
	int tela = 0;
	sf::Font font;
	font.loadFromFile("fonte.TTF"); //lê a fonte
	sf::Texture fundo;
	sf::Texture sairtextura;
	fundo.loadFromFile("telaperdeu.png"); //fundo do menu
	sairtextura.loadFromFile("sair.png"); //textura expert
	sf::Sprite sair;
	sf::Sprite fundoperdeu;
	sair.setTexture(sairtextura);
	sair.setPosition(430, 500);
	fundoperdeu.setTexture(fundo);
	fundoperdeu.setPosition(0, 0);
	sf::Text textinho2;
	string textoo2;
	textoo2 = to_string(pontuacao);
	textinho2.setString(textoo2);
	textinho2.setPosition(sf::Vector2f(430, 330));
	textinho2.setColor(sf::Color::White);
	textinho2.setFont(font);
	textinho2.setCharacterSize(60);
	while (tela != 1) {
		window.draw(fundoperdeu);
		window.draw(textinho2);
		window.display();
		while (clock.getElapsedTime() < sf::seconds(4)) {
		}
		if (spriteClick(sair, window))
		{
			window.close();
		}
	}
}