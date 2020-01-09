#pragma once
#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

int tela4Instucoes(sf::RenderWindow &window) {
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc

	int tela = 0;
	sf::Texture tela4textura;
	sf::Texture sairtextura;
	tela4textura.loadFromFile("instrucoes4.png");
	sairtextura.loadFromFile("sair.png");
	sf::Sprite sair;
	sf::Sprite tela4;
	sair.setTexture(sairtextura);
	sair.setPosition(430, 500);
	tela4.setTexture(tela4textura);
	while (tela != 1) {
		window.draw(tela4);
		window.display();
		while (clock.getElapsedTime() < sf::seconds(1)) {
		}
		if (spriteClick(sair, window))
		{
			return 0;
		}
	}
}