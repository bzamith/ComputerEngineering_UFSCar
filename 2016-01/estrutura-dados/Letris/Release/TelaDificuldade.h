#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

int telaDificuldade(sf::RenderWindow &window) {
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc
	int tela = 0;
	sf::Texture fundo;
	sf::Texture iniciantetextura;
	sf::Texture avancadotextura;
	sf::Texture expertextura;
	fundo.loadFromFile("dificuldade.png"); //fundo do menu
	iniciantetextura.loadFromFile("iniciante.png"); //textura iniciante
	avancadotextura.loadFromFile("avancado.png"); //textura avancado
	expertextura.loadFromFile("expert.png"); //textura expert
	sf::Sprite fundodificuldade;
	sf::Sprite iniciante;
	sf::Sprite avancado;
	sf::Sprite expert;
	iniciante.setTexture(iniciantetextura);
	iniciante.setPosition(90, 240);
	avancado.setTexture(avancadotextura);
	avancado.setPosition(90, 342);
	expert.setTexture(avancadotextura);
	expert.setPosition(90, 415);
	fundodificuldade.setTexture(fundo);
	fundodificuldade.setPosition(0, 0);
	while (tela != 1) {
		window.draw(fundodificuldade);
		window.display();
		while (clock.getElapsedTime() < sf::seconds(1)) {
		}
		if (spriteClick(iniciante, window))
		{
			return 1;
		}
		else if (spriteClick(avancado, window))
		{
			return  2;
		}
		else if (spriteClick(expert, window))
		{
			return 3;
		}
	}
}