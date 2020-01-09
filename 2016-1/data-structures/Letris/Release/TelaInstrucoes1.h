#pragma once
#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>
#include "SpriteClick.h"
using namespace std;

int tela1Instucoes(sf::RenderWindow &window) {
	sf::Clock clock; //clock para cair e ser compativel com qualquer pc

	int tela = 0;
	sf::Texture tela1textura;
	sf::Texture sairtextura;
	tela1textura.loadFromFile("instrucoes1.png");
	sf::Sprite sair;
	sairtextura.loadFromFile("sair.png");
	sf::Sprite tela1;
	sair.setTexture(sairtextura);
	sair.setPosition(430, 500);
	tela1.setTexture(tela1textura);

	while (tela != 1) {
		window.draw(tela1);
		window.display();
		while (clock.getElapsedTime() < sf::seconds(1)) {
		}
		if (spriteClick(sair, window))
		{
			return 0;
		}
	}
}